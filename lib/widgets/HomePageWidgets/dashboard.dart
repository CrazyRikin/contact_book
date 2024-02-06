import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(builder: (context, contactlistprovider, child) => Container(child: Card(child: Row(children: [Column(),],)),));
  }
}