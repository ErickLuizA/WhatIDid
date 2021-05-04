import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/viewmodels/categories_viewmodel.dart'
    hide State;
import 'package:whatidid/application/providers/viewmodels/create_viewmodel.dart';
import 'package:whatidid/domain/models/category.dart';
import 'package:whatidid/presentation/app_localizations.dart';

class CreateCategoryWidget extends StatefulWidget {
  @override
  _CreateCategoryWidgetState createState() => _CreateCategoryWidgetState();
}

class _CreateCategoryWidgetState extends State<CreateCategoryWidget> {
  String? name;

  String? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("create_category")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText:
                      AppLocalizations.of(context).translate("category_name"),
                  hintStyle: Theme.of(context).primaryTextTheme.bodyText1,
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).primaryTextTheme.bodyText1,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
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
                    final isValid = name != null && name!.length > 1;

                    if (isValid) {
                      final data = Category(image: image, name: name!).toMap();

                      final result = await context
                          .read(createViewModelProvider)
                          .insert(data);

                      if (!result) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            AppLocalizations.of(context)
                                .translate("failure_add_category"),
                          )),
                        );
                      } else {
                        context
                            .read(categoriesViewModelProvider.notifier)
                            .getAll();

                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      }
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
