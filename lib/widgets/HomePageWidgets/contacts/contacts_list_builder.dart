import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:contact_book/widgets/HomePageWidgets/contacts/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListBuilder extends StatelessWidget {
  const ContactListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistbuilder, child) => ListView.builder(
        itemCount: contactlistbuilder.registeredContacts.length,
        itemBuilder: (context, index) => Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: ContactCard(
            index: index,
          ),
        ),
      ),
    );
  }
}
