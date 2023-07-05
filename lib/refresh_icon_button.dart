import 'package:flutter/material.dart';

class RefreshIconButton extends StatefulWidget {
  const RefreshIconButton({super.key, required this.task, this.controller});
  final Function task;
  final AnimationController? controller;

  @override
  State<RefreshIconButton> createState() => _RefreshIconButtonState();
}

class _RefreshIconButtonState extends State<RefreshIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = widget.controller == null
      ? AnimationController(vsync: this, duration: const Duration(seconds: 1))
      : widget.controller!;
  late bool isUpdating = _controller.isAnimating;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: IconButton(
        tooltip: "Refresh all users",
        icon: const Icon(Icons.refresh_rounded),
        onPressed: isUpdating
            ? null
            : () async {
                _controller.repeat();

                setState(() {
                  isUpdating = _controller.isAnimating;
                });

                await widget.task();
                _controller.stop();
                await _controller.forward();

                setState(() {
                  isUpdating = _controller.isAnimating;
                });
              },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
