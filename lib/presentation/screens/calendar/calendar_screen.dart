import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatidid/application/providers/viewmodels/calendar_viewmodel.dart'
    hide State;
import 'package:whatidid/presentation/app_localizations.dart';
import 'package:whatidid/presentation/widgets/entrie_widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context
          .read(calendarViewModelProvider.notifier)
          .getMonthAll(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime.utc(2000),
            lastDate: DateTime.utc(2100),
            onDisplayedMonthChanged: (DateTime newDate) {
              context
                  .read(calendarViewModelProvider.notifier)
                  .getMonthAll(newDate);
            },
            onDateChanged: (DateTime newDate) {
              context
                  .read(calendarViewModelProvider.notifier)
                  .getDayAll(newDate);
            },
          ),
          Expanded(
            child: ProviderListener(
              provider: calendarViewModelProvider,
              onChange: (context, state) {
                if (state is ErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        AppLocalizations.of(context)
                            .translate("unexpect_error"),
                      ),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Consumer(
                  builder: (context, watch, child) {
                    final state = watch(calendarViewModelProvider);

                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is LoadedState) {
                      return ListView.builder(
                        itemCount: state.result.length,
                        itemBuilder: (context, index) {
                          final entrie = state.result[index];
                          return EntrieWidget(entrie);
                        },
                      );
                    }

                    if (state is EmptyState) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context)
                              .translate("nothing_here"),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
