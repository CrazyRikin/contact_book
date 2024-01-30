import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({required this.index, super.key});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                  contactlistprovider.registeredContacts[index].name
                      .toUpperCase(),
                  style: const TextStyle(fontSize: 20)),
              Container(
                color: Theme.of(context).colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    contactlistprovider.registeredContacts[index].group.name
                        .toString()
                        .toUpperCase(),
                    style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
              Text(
                  contactlistprovider.registeredContacts[index].company
                      .toUpperCase(),
                  style: const TextStyle(fontSize: 12)),
              Text(
                  contactlistprovider.registeredContacts[index].email
                      .toUpperCase(),
                  style: const TextStyle(fontSize: 12)),
            ]),
            const Spacer(),
            IconButton.filled(
                onPressed: () async {
                  Uri phoneNo = Uri.parse(contactlistprovider
                      .registeredContacts[index].phone
                      .toString());
                  await launchUrl(phoneNo);
                },
                icon: const Icon(Icons.call))
          ]),
        ),
      ),
    );
  }
}
