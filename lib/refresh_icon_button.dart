import 'package:flutter/material.dart';

class RefreshIconButton extends StatefulWidget {
  const RefreshIconButton(
      {super.key,
      required this.task,
      this.controller,
      this.postHook,
      this.tooltip = 'Refresh'});

  final Function task;
  final Function? postHook;
  final AnimationController? controller;
  final String? tooltip;

  @override
  State<RefreshIconButton> createState() => _RefreshIconButtonState();
}

class _RefreshIconButtonState extends State<RefreshIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = widget.controller == null
      ? AnimationController(vsync: this, duration: const Duration(seconds: 1))
      : widget.controller!;

  late bool isRefreshing = _controller.isAnimating;

  void onPress() async {
    _controller.repeat();

    setState(() {
      isRefreshing = _controller.isAnimating;
    });

    await widget.task();
    _controller.stop();
    await _controller.forward();

    setState(() {
      isRefreshing = _controller.isAnimating;
    });
    await widget.postHook?.call();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: IconButton(
        tooltip: widget.tooltip,
        icon: const Icon(Icons.refresh_rounded),
        onPressed: isRefreshing ? null : onPress,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
