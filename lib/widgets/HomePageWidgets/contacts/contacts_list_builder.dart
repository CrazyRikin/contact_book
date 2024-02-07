import 'package:contact_book/services/providers/contacts_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactListBuilder extends StatelessWidget {
  const ContactListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => ListView.builder(
        itemCount: contactlistprovider.registeredContacts.length,
        itemBuilder: (context, index) => Container(
          color: Theme.of(context).colorScheme.onPrimary,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      contactlistprovider.registeredContacts[index].name
                          .substring(0, 2)
                          .toUpperCase(), 
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      contactlistprovider.registeredContacts[index].name
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 20)),
                  Row(
                    children: [
                      Container(
                        color: Theme.of(context).colorScheme.primary,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            contactlistprovider
                                .registeredContacts[index].dept.name
                                .toString()
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 10,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                      contactlistprovider.registeredContacts[index].company
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 12)),
                  Text(
                      contactlistprovider.registeredContacts[index].title
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 12)),
                  Text(
                      contactlistprovider.registeredContacts[index].email
                          .toUpperCase(),
                      style: const TextStyle(fontSize: 12)),
                ]),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      contactlistprovider.deleteContact(index);
                    },
                    icon: const Icon(Icons.delete, size: 20))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
