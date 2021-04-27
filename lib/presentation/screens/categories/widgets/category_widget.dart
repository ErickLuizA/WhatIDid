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
    print(category);

    return Column(
      children: [
        showImage(),
        showText(context),
      ],
    );
  }

  Widget showText(BuildContext context) {
    if (category.name == 'Daily') {
      return Text(AppLocalizations.of(context).translate('daily'));
    }

    return Text(category.name);
  }

  Widget showImage() {
    if (category.image == null) {
      return SvgPicture.asset('assets/images/notebook.svg');
    }

    if (category.image!.contains('assets/')) {
      return SvgPicture.asset(category.image!);
    }

    return Image.file(
      File(category.image!),
    );
  }
}
