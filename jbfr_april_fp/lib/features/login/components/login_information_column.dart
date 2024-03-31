import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginInformationColumnWidget extends StatefulWidget {
  final String text;
  final String buttonText;
  final Function() onPressed;

  const LoginInformationColumnWidget({super.key, required this.text, required this.buttonText, required this.onPressed});

  @override
  State<LoginInformationColumnWidget> createState() => _LoginInformationColumnWidgetState();
}

class _LoginInformationColumnWidgetState extends State<LoginInformationColumnWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          widget.text,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const SizedBox(height: 20),
        FilledButton(
            child: Text(widget.buttonText),
            onPressed: widget.onPressed),
      ],
    );
  }
}