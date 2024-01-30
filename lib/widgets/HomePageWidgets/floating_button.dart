import 'package:contact_book/services/functions/home_page_functions.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  const CustomFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text("one"), Text(("two"))],
              ),
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
