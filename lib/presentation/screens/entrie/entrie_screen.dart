import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatidid/application/providers/viewmodels/entries_viewmodel.dart';
import 'package:whatidid/domain/models/entrie.dart';
import 'package:whatidid/presentation/app_localizations.dart';
import 'package:whatidid/presentation/utils/num_to_month.dart';
import 'package:whatidid/presentation/utils/num_to_weekday.dart';

class EntrieScreen extends StatelessWidget {
  final Entrie entrie;

  EntrieScreen(this.entrie);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 4;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height),
        child: SafeArea(
          child: Stack(
            children: [
              Center(child: showImage(context)),
              AppBar(
                backgroundColor: Colors.transparent,
                actions: [
                  PopupMenuButton(
                    onSelected: (String selected) async {
                      if (selected == "delete") {
                        final res = await context
                            .read(entriesViewModelProvider.notifier)
                            .delete(entrie.id!);

                        if (res) {
                          if (Navigator.canPop(context)) {
                            context
                                .read(entriesViewModelProvider.notifier)
                                .getAll(entrie.category);

                            Navigator.pop(context);
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)
                                  .translate('error_deleting_entrie')),
                            ),
                          );
                        }
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: "delete",
                          child: Text(
                              AppLocalizations.of(context).translate('delete')),
                        ),
                      ];
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  text: "${numToWeekday(entrie.dateTime.day)}, ",
                  children: [
                    TextSpan(
                      text: "${entrie.dateTime.day} ",
                    ),
                    TextSpan(
                      text: "${numToMonth(entrie.dateTime.month)} ",
                    ),
                    TextSpan(
                      text: "${entrie.dateTime.year} ",
                    ),
                  ],
                ),
                style: Theme.of(context).primaryTextTheme.headline5,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                  ),
                  Text(
                    "${entrie.dateTime.hour}:${entrie.dateTime.minute}",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "${entrie.category}",
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                entrie.title,
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "${entrie.content}",
                style: Theme.of(context).primaryTextTheme.bodyText1,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showImage(BuildContext context) {
    if (entrie.image == null) {
      return SvgPicture.asset(
        'assets/images/notebook.svg',
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(entrie.image!),
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) {
          return SvgPicture.asset(
            'assets/images/notebook.svg',
          );
        },
      );
    }
  }
}
