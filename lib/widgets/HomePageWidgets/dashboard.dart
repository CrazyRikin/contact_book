import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactListProvider>(
      builder: (context, contactlistprovider, child) => Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(0, 255, 255, 255),
            borderRadius: BorderRadius.all(Radius.circular(6))),
        height: MediaQuery.of(context).size.height * 0.15,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("DASHBOARD",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      )),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contactlistprovider.registeredContacts.length
                                .toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text("TOTAL CONTACTS")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contactlistprovider.hrCount().toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text("HR")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contactlistprovider.techCount().toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text("TECH")
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            contactlistprovider.marketingCount().toString(),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Text("MARKETING")
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
