import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/viewmodels/create_viewmodel.dart';
import 'package:whatidid/application/providers/viewmodels/entries_viewmodel.dart'
    hide State;
import 'package:whatidid/domain/models/entrie.dart';
import 'package:whatidid/presentation/app_localizations.dart';

class CreateEntrieWidget extends StatefulWidget {
  final String category;

  CreateEntrieWidget(this.category);

  @override
  _CreateEntrieWidgetState createState() => _CreateEntrieWidgetState();
}

class _CreateEntrieWidgetState extends State<CreateEntrieWidget> {
  String title = '';
  String content = '';
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
            "${AppLocalizations.of(context).translate('create_entrie')} ${widget.category}"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate("title"),
                  hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).primaryTextTheme.bodyText1,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate("content"),
                  hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
                  border: OutlineInputBorder(),
                ),
                minLines: 4,
                maxLines: 20,
                style: Theme.of(context).primaryTextTheme.bodyText1,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "${date.year} / ${date.month} / ${date.day}",
                  labelStyle: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                readOnly: true,
                onTap: () async {
                  final newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime.utc(2000),
                    lastDate: DateTime.utc(2100),
                  );

                  if (newDate != null) {
                    setState(() {
                      date = DateTime(
                        newDate.year,
                        newDate.month,
                        newDate.day,
                      );
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: "${time.hour}:${time.minute}",
                  labelStyle: Theme.of(context).primaryTextTheme.bodyText1,
                ),
                readOnly: true,
                onTap: () async {
                  final newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );

                  if (newTime != null) {
                    setState(() {
                      time = newTime;
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              Builder(
                builder: (context) {
                  if (image != null) {
                    return Image.file(
                      File(image!),
                      errorBuilder: (
                        BuildContext context,
                        Object exception,
                        StackTrace? stackTrace,
                      ) {
                        setState(() {
                          image = null;
                        });

                        return Text('😢');
                      },
                    );
                  }

                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        allowMultiple: false,
                      );

                      setState(() {
                        image = result?.files.single.path;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Placeholder(
                          color: Colors.grey,
                          fallbackHeight:
                              MediaQuery.of(context).size.height / 3,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .translate("click_to_add"),
                          style: Theme.of(context).primaryTextTheme.headline5,
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 20),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorLight,
                    ),
                  ),
                  onPressed: () async {
                    final isValid = title.isNotEmpty && content.isNotEmpty;

                    if (isValid) {
                      final data = Entrie(
                        title: title,
                        image: image,
                        content: content,
                        category: widget.category,
                        dateTime: DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        ),
                      ).toMap();

                      final result = await context
                          .read(createViewModelProvider)
                          .insertEntrie(data);

                      if (!result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)
                                .translate("failure_add_entrie")),
                          ),
                        );
                      } else {
                        context
                            .read(entriesViewModelProvider.notifier)
                            .getAll(widget.category);

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)
                              .translate("fill_all")),
                        ),
                      );
                    }
                  },
                  child: Text(AppLocalizations.of(context).translate("submit")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
