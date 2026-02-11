import 'package:blabla/theme/theme.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import 'custom_test_screen.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTestScreen(
      content: [
        SizedBox(height: 30),
        BlaButton(label: "Contact Me", onTap: () {}),
        SizedBox(height: 30),

        BlaButton(label: "Contact Me", onTap: () {}, isSecondary: true),
        SizedBox(height: 30),

        BlaButton(
          label: "Contact Me",
          onTap: () {},
          iconData: Icons.contact_page,
        ),
        SizedBox(height: 30),

        BlaButton(
          label: "Contact Me",
          onTap: () {},
          iconData: Icons.contact_page,
          isSecondary: true,
        ),
      ],
      screenTitle: 'BlaButton Test',
    );
  }
}

void main() {
  runApp(MaterialApp(home: BlaButtonTestScreen()));
}
