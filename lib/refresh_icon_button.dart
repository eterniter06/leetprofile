import 'package:flutter/material.dart';

class RefreshIconButton extends StatefulWidget {
  const RefreshIconButton(
      {super.key,
      required this.task,
      this.controller,
      this.postHook,
      this.tooltip = 'Refresh',
      this.globalKey});

  final GlobalKey<RefreshIconButtonState>? globalKey;
  final Function task;
  final Function? postHook;
  final AnimationController? controller;
  final String? tooltip;

  @override
  State<RefreshIconButton> createState() => RefreshIconButtonState();
}

class RefreshIconButtonState extends State<RefreshIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = widget.controller == null ||
          !widget.controller!.isAnimating
      ? AnimationController(vsync: this, duration: const Duration(seconds: 1))
      : widget.controller!;

  late bool isRefreshing = _controller.isAnimating;
  late Function? task = widget.task;
  late Function? postHook;
  bool globalSync = false;

  Future<void> onPress() async {
    _controller.repeat();

    setState(() {
      isRefreshing = _controller.isAnimating;
    });

    await task?.call();

    _controller.stop();
    await _controller.forward();

    setState(() {
      isRefreshing = _controller.isAnimating;
    });

    await postHook?.call();
  }

  @override
  void initState() {
    super.initState();

    if ((widget.globalKey?.currentState?._controller.isAnimating ?? false)) {
      task = null;
      postHook =
          (widget.globalKey?.currentWidget as RefreshIconButton).postHook;
      widget.globalKey?.currentState?.postHook = null;

      onPress();
    }

    task = widget.task;
    postHook = widget.postHook;
  }

  @override
  Widget build(BuildContext context) {
    postHook = widget.postHook;

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
