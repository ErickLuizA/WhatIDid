import 'package:flutter/material.dart';

import 'package:whatidid/domain/models/entrie.dart';

class EntrieWidget extends StatelessWidget {
  final Entrie entrie;

  const EntrieWidget(this.entrie);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: Column(),
        ),
        Flexible(
          flex: 2,
          child: Column(),
        ),
      ],
    );
  }
}
