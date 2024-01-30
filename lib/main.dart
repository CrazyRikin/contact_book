import 'package:contact_book/pages/home_page.dart';
import 'package:contact_book/services/providers/contacts_provider.dart';
import 'package:provider/provider.dart';
import 'package:contact_book/utils/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactListProvider(),
        )
      ],
      child: MaterialApp(
        theme: kTheme,
        home: const HomePage(),
      ),
    ),
  );
}
