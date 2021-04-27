import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/presentation/app_localizations.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;

  const CategoryWidget(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          showImage(context),
          showText(context),
        ],
      ),
    );
  }

  Widget showText(BuildContext context) {
    if (category.name == 'Daily') {
      return Text(
        AppLocalizations.of(context).translate('daily'),
        style: Theme.of(context).primaryTextTheme.bodyText1,
      );
    }

    return Text(
      category.name,
      style: Theme.of(context).primaryTextTheme.bodyText1,
    );
  }

  Widget showImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 2.5;

    if (category.image == null) {
      return SvgPicture.asset(
        'assets/images/notebook.svg',
        width: width,
      );
    }

    if (category.image!.contains('assets/')) {
      return SvgPicture.asset(
        category.image!,
        width: width,
      );
    }

    return Image.file(
      File(category.image!),
      width: width,
    );
  }
}
