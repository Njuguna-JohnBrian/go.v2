import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';
import 'package:intl/intl.dart';

class TripsCalendarSection extends StatefulWidget {
  final TextEditingController endDateController;
  final TextEditingController startDateController;
  const TripsCalendarSection({
    Key? key,
    required this.endDateController,
    required this.startDateController,
  }) : super(key: key);

  @override
  State<TripsCalendarSection> createState() => _TripsCalendarSectionState();
}

class _TripsCalendarSectionState extends State<TripsCalendarSection> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: TextFormField(
                controller: widget.startDateController,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    helpText: "Select start date",
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      widget.startDateController.text = DateFormat(
                        "MMMM dd yyyy",
                      ).format(
                        value,
                      );
                    }
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: DateFormat('MMMM dd yyyy').format(
                    DateTime.now(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.calendar_today_sharp,
              color: Colors.grey,
              size: 30,
            ),
            SizedBox(
              width: size.width * 0.10,
            ),
            SizedBox(
              width: size.width * 0.75,
              child: TextFormField(
                controller: widget.endDateController,
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Please provide an end date";
                  } else {
                    return null;
                  }
                }),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onTap: () async {
                  await showDatePicker(
                    context: context,
                    helpText: "Select end date",
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(
                      DateTime.now().year + 5,
                    ),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: GoTheme.mainColor,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.blueAccent,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  ).then((value) {
                    if (value != null) {
                      widget.endDateController.text = DateFormat(
                        'MMMM dd yyyy',
                      ).format(
                        value,
                      );
                    }
                  });
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  labelStyle: GoTheme.lightTextTheme.headline6,
                  hintText: "End Date",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
