import 'package:blabla/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomTestScreen extends StatelessWidget {
  const CustomTestScreen({
    super.key,
    required this.content,
    required this.screenTitle,
  });
  final List<Widget> content;
  final String screenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        backgroundColor: BlaColors.primary,
      ),
      body: ListView(children: [...content]),
    );
  }
}
