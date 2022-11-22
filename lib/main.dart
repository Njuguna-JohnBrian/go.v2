import 'package:flutter/material.dart';
import 'package:go/theme/go_theme.dart';

void main() {
  runApp(const Go());
}

class Go extends StatelessWidget {
  const Go({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GoTheme.light(),
      title: 'gO',
      home: const Scaffold(),
    );
  }
}
