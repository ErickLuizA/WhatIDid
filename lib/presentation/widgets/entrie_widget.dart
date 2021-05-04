import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatidid/application/constants/app_routes.dart';

import 'package:whatidid/domain/models/entrie.dart';
import 'package:whatidid/presentation/utils/num_to_month.dart';
import 'package:whatidid/presentation/utils/num_to_weekday.dart';

class EntrieWidget extends StatelessWidget {
  final Entrie entrie;

  const EntrieWidget(this.entrie);

  @override
  Widget build(BuildContext context) {
    final length = entrie.content.length >= 20 ? 20 : entrie.content.length;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.ENTRIE, arguments: {
          "entrie": entrie,
        });
      },
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Text(
                  numToMonth(entrie.dateTime.month),
                  style: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                Text(
                  "${entrie.dateTime.day}",
                  style: Theme.of(context).primaryTextTheme.headline6,
                ),
                Text(
                  numToWeekday(entrie.dateTime.weekday),
                  style: Theme.of(context).primaryTextTheme.headline5,
                ),
                Container(
                  width: 2,
                  height: 40,
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: Row(
              children: [
                showImage(context),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entrie.title,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "${entrie.content.substring(0, length)}...",
                      style: Theme.of(context).primaryTextTheme.bodyText1,
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2
                              ?.color,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "${entrie.dateTime.hour}:${entrie.dateTime.hour}",
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage(BuildContext context) {
    final width = MediaQuery.of(context).size.width / 3;
    final height = MediaQuery.of(context).size.height / 5;

    if (entrie.image == null) {
      return SvgPicture.asset(
        'assets/images/notebook.svg',
        width: width,
      );
    } else {
      return Image.file(
        File(entrie.image!),
        width: width,
        height: height,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return SvgPicture.asset(
            'assets/images/notebook.svg',
            width: width,
          );
        },
      );
    }
  }
}
