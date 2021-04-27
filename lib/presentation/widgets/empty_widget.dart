import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  final String text;
  const EmptyWidget(this.text);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "There is nothing here",
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Press the",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            Icon(
              Icons.add_circle,
              color: Theme.of(context).accentColor,
            ),
            Text(
              "to add a $text",
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(height: 10),
        SvgPicture.asset(
          'assets/images/empty.svg',
          width: MediaQuery.of(context).size.width / 2,
        ),
      ],
    );
  }
}
