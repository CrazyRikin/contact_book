import 'package:flutter/material.dart';

class ImportContacts extends StatelessWidget {
  const ImportContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text("Import Contacts"),
        ));
  }
}
