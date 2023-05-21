import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_contacts_tdd/persentation/blox/contacts_bloc/contacts_bloc.dart';
import 'package:save_contacts_tdd/persentation/screens/contacts_screen/contacts_screen.dart';

import 'core/injection_container/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContactsBloc>(
      create: (context) => sl<ContactsBloc>()..add(GetAllContacts()),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: ContactsScreen(),
      ),
    );
  }
}

