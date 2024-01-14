import 'package:flutter/material.dart';

class TrailingScrollButton extends StatefulWidget {
  const TrailingScrollButton({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<TrailingScrollButton> createState() => _TrailingScrollButtonState();
}

class _TrailingScrollButtonState extends State<TrailingScrollButton>
    with TickerProviderStateMixin {
  late final Animation<double> animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.fastOutSlowIn,
  );

  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late Axis axis;
  late double scrollOffset;

  @override
  void initState() {
    super.initState();

    // Todo: Figure out a more reliable way to detect if list is scrollable
    // Source: https://stackoverflow.com/questions/65358691/how-to-know-if-list-view-is-scrollable-programatically
    if (widget.scrollController.position.maxScrollExtent > 0) {
      widget.scrollController.addListener(() => _scrollLogic());
    }

    axis = widget.scrollController.position.axis;
    Size physicalSize =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;

    if (axis == Axis.horizontal) {
      scrollOffset = physicalSize.width;
    } else {
      scrollOffset = physicalSize.height;
    }
  }

  void _scrollLogic() {
    if (widget.scrollController.position.pixels ==
        widget.scrollController.position.maxScrollExtent) {
      animationController.forward();
    }
    if (animationController.isCompleted) {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(() => _scrollLogic());
    animationController.dispose();

    super.dispose();
  }

  void scrollForward() {
    widget.scrollController.animateTo(
      widget.scrollController.position.pixels + scrollOffset / 4.8,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void scrollToStart() {
    widget.scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  void scrollReverse() {
    widget.scrollController.animateTo(
      widget.scrollController.position.pixels - scrollOffset / 4.8,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: RotationTransition(
        turns: Tween(begin: 0.0, end: 0.5).animate(animation),
        child: Icon(
          Icons.double_arrow_rounded,
          color: MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ),
      ),
      tooltip: 'Scroll languages',
      onPressed: () => widget.scrollController.position.extentAfter > 0
          ? scrollForward()
          : scrollToStart(),
    );
  }
}
