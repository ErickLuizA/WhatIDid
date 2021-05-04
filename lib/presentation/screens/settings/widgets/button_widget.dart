import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  const ButtonWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).primaryColorLight,
      ),
      child: child,
    );
  }
}
