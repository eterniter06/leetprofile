import 'dart:math';

import 'package:flutter/material.dart';

class ExtensibleAnimatedWrap extends StatefulWidget {
  const ExtensibleAnimatedWrap({
    required this.children,
    this.spacing,
    this.defaultItemCount,
    super.key,
  });
  final double? spacing;
  final List<Widget> children;
  final int? defaultItemCount;
  @override
  State<ExtensibleAnimatedWrap> createState() => _ExtensibleAnimatedWrapState();
}

class _ExtensibleAnimatedWrapState extends State<ExtensibleAnimatedWrap> {
  List<Widget> list = [];
  List<Function> callback = [];
  bool expanded = false;
  Duration animationDuration = const Duration(milliseconds: 0);

  late int defaultItemCount = widget.defaultItemCount != null
      ? min(widget.defaultItemCount!, widget.children.length)
      : widget.children.length;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < defaultItemCount; ++i) {
      list.add(widget.children[i]);
    }

    if (widget.defaultItemCount != null) {
      int animatedWidgetCount = widget.children.length - defaultItemCount;

      if (animatedWidgetCount < 8) {
        animationDuration = const Duration(milliseconds: 80);
      } else if (animatedWidgetCount < 20) {
        animationDuration = const Duration(milliseconds: 48);
      } else {
        animationDuration = const Duration(milliseconds: 30);
      }
    }
  }

  void toggle() {
    if (widget.defaultItemCount != null) {
      if (!expanded) {
        for (int i = defaultItemCount; i < widget.children.length; ++i) {
          setState(() {
            list.add(
              ExtensibleAnimatedWrapChild(
                  duration: animationDuration,
                  onEnd: () => setState(() {
                        list.removeAt(i);
                      }),
                  toggle: (toggleVisibility) {
                    callback.add(toggleVisibility);
                  },
                  child: widget.children[i]),
            );
          });
        }
      } else {
        setState(() {
          for (int i = callback.length - 1; i >= 0; --i) {
            callback[i].call();
          }
          callback.clear();
        });
      }
      setState(() {
        expanded = !expanded;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: widget.spacing ?? 0.0,
      children: [
        ...list,
        if (widget.children.length > defaultItemCount)
          ElevatedButton(
            child: AnimatedCrossFade(
              duration: animationDuration,
              crossFadeState: CrossFadeState.showFirst,
              firstChild: widget.children.length == list.length
                  ? const Text('Show less')
                  : const Text('Show more'),
              secondChild: widget.children.length != list.length
                  ? const Text('Show less')
                  : const Text('Show more'),
            ),
            onPressed: () => toggle(),
          ),
      ],
    );
  }
}

/// [ExtensibleAnimatedWrapChild] is the wrapper for the children of [ExtensibleAnimatedWrap]
/// used for animating the opacity and removing the child from the wrap list as required
class ExtensibleAnimatedWrapChild extends StatefulWidget {
  const ExtensibleAnimatedWrapChild(
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
  State<ExtensibleAnimatedWrapChild> createState() =>
      ExtensibleAnimatedWrapChildState();
}

class ExtensibleAnimatedWrapChildState
    extends State<ExtensibleAnimatedWrapChild> {
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

  void remove() {
    setState(() {
      if (_opacity == 0.0) {
        _visibility = false;
        widget.onEnd?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainAnimation: true,
      maintainState: true,
      visible: _visibility,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _opacity,
        child: widget.child,
        onEnd: () => remove(),
      ),
    );
  }
}
