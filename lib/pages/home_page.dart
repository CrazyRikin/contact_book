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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("DashBoard"),
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => const Center(child: Text("Item")),
          ))
        ],
      )),
    );
  }
}
