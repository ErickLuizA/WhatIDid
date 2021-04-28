import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatidid/presentation/app_localizations.dart';

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
          AppLocalizations.of(context).translate("nothing_here"),
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).translate("press_the"),
              style: Theme.of(context).primaryTextTheme.bodyText1,
            ),
            Icon(
              Icons.add_circle,
              color: Theme.of(context).accentColor,
            ),
            Text(
              "${AppLocalizations.of(context).translate("to_add")} ${AppLocalizations.of(context).translate(text)}",
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
