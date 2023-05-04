import 'package:flutter/material.dart';

class ElevatedPillButton extends StatelessWidget {
  const ElevatedPillButton(
      {super.key, required this.tapAction, required this.child});
  final Widget child;
  final VoidCallback tapAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: tapAction,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
