import 'package:flutter/material.dart';

class AnimatedTag extends StatefulWidget {
  const AnimatedTag(
      {this.onEnd,
      this.toggle,
      required this.duration,
      required this.child,
      super.key});

  final Function? onEnd;
  final Widget child;
  final Duration duration;
  final void Function(Function toggleVisibility)? toggle;

  @override
  State<AnimatedTag> createState() => AnimatedTagState();
}

class AnimatedTagState extends State<AnimatedTag> {
  double _opacity = 0.0;
  late bool _visibility = true;

  @override
  void initState() {
    super.initState();
    widget.toggle?.call(toggleVisibility);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void toggleVisibility() {
    setState(() {
      if (_opacity == 0.0) {
        _visibility = true;
        _opacity = 1.0;
      } else {
        _opacity = 0.0;
      }
    });
  }

  void removeTag() {
    setState(() {
      if (_opacity == 0.0) {
        _visibility = false;
        widget.onEnd?.call();
      }
    });
    print('Destructed');
  }

  @override
  Widget build(BuildContext context) {
    print('Opacity : $_opacity, visibility: $_visibility');
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: _visibility,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _opacity,
        child: widget.child,
        onEnd: () => removeTag(),
      ),
    );
  }
}
