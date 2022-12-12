import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go/theme/go_theme.dart';
import 'package:intl/intl.dart';

class TripsScreen extends StatelessWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "New trip",
          style: GoTheme.lightTextTheme.headline6?.copyWith(
            color: GoTheme.mainColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ),
          color: GoTheme.mainColor,
          iconSize: 25,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Center(
              child: Text(
                "Save",
                style: GoTheme.lightTextTheme.headline6?.copyWith(
                  color: GoTheme.mainColor,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        color: Colors.grey,
                        padding: const EdgeInsets.all(20),
                        strokeWidth: 1,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          color: Colors.grey,
                          iconSize: 25,
                          onPressed: () {},
                        )),
                    SizedBox(
                      width: size.width * 0.10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.black.withOpacity(0.4),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      width: size.width * 0.35,
                      height: size.height * 0.04,
                      child: Text(
                        "Change cover photo",
                        style: GoTheme.darkTextTheme.bodyText1
                            ?.copyWith(fontSize: 10, color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30.0,
                    bottom: 30.0,
                  ),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.title,
                          color: Colors.grey,
                          size: 30,
                        ),
                        SizedBox(
                          width: size.width * 0.10,
                        ),
                        SizedBox(
                          width: size.width * 0.75,
                          child: TextFormField(
                            decoration:  InputDecoration(
                              labelText: 'Trip Name/Title',
                              labelStyle: GoTheme.lightTextTheme.headline6,
                              hintText: 'e.g African Road trip',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.summarize_outlined,
                          color: Colors.grey,
                          size: 30,
                        ),
                        SizedBox(
                          width: size.width * 0.10,
                        ),
                        SizedBox(
                          width: size.width * 0.75,
                          child: TextFormField(
                            maxLines: 2,
                            decoration:  InputDecoration(
                              labelText: 'Trip summary',
                              labelStyle: GoTheme.lightTextTheme.headline6,
                              hintText:
                                  'e.g An awesome road trip through the desserts on Africa with my family',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30.0,
                  ),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Column(
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
                              );
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Start Date',
                              labelStyle: GoTheme.lightTextTheme.headline6,
                              hintText: DateFormat('MMMM dd yyyy').format(
                                DateTime.now(),
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
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
                              );
                            },
                            readOnly: true,
                            decoration:  InputDecoration(
                              labelText: 'End Date',
                              labelStyle: GoTheme.lightTextTheme.headline6,
                              hintText: "End Date",
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30.0,
                  ),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    SizedBox(
                      width: size.width * 0.45,
                      child: TextFormField(
                        onTap: () {},
                        readOnly: true,
                        decoration:  InputDecoration(
                          labelText: 'Travel Tracker',
                          labelStyle: GoTheme.lightTextTheme.headline6,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.16,
                    ),
                    Switch(value: false, onChanged: (value) {})
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30,
                    bottom: 30.0,
                  ),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.privacy_tip_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.10,
                    ),
                    SizedBox(
                      width: size.width * 0.75,
                      child: TextFormField(
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Who can see this trip?'),
                                content: const Text('A dialog is a type of modal window that\n'
                                    'appears in front of app content to\n'
                                    'provide critical information, or prompt\n'
                                    'for a decision to be made.'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Disable'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      textStyle: Theme.of(context).textTheme.labelLarge,
                                    ),
                                    child: const Text('Enable'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        readOnly: true,
                        decoration:  InputDecoration(
                          labelText: 'Who can view this trip?',
                          labelStyle: GoTheme.lightTextTheme.headline6,
                          hintText: "My Followers",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
