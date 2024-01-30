import 'package:contact_book/widgets/HomePageWidgets/contacts/contacts_list_builder.dart';
import 'package:contact_book/widgets/HomePageWidgets/floating_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CustomFloatingButton(),
      appBar: AppBar(title: const Text("Contact Book !")),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("DashBoard"),
              Expanded(child: ContactListBuilder())
            ],
          ),
        ),
      ),
    );
  }
}
