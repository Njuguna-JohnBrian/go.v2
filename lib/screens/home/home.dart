import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

import '../../globals/components/global_screens.dart';
import '../../globals/components/global_spinner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    Timer(const Duration(seconds: 0), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const GlobalSpinner()
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  pageIndex = index;
                });
              },
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              type: BottomNavigationBarType.shifting,
              selectedItemColor: GoTheme.mainColor,
              unselectedItemColor: Colors.grey.shade700,
              unselectedFontSize: 8,
              currentIndex: pageIndex,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.search,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.people_outline_outlined,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_pin,
                  ),
                  label: '',
                ),
              ],
            ),
            body: Center(child: goPages[pageIndex]),
          );
  }
}
