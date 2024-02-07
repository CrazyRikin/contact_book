import 'package:flutter/material.dart';

class AlertBoxClass extends StatefulWidget {
  const AlertBoxClass({super.key});

  @override
  State<AlertBoxClass> createState() => _AlertBoxClassState();
}

class _AlertBoxClassState extends State<AlertBoxClass> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Invalid Input'),
      content: const SingleChildScrollView(
          child: Column(
        children: [
          Text("Please enter valid data. Ensure to atleast add name and phone")
        ],
      )),
      actions: <Widget>[
        TextButton(
          child: const Text('Okay!'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
