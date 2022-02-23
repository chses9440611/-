import 'package:flutter/material.dart';
import 'package:practice/config/firebase_options.dart';
import 'package:practice/pages/welcome_page.dart';
import 'package:practice/pages/new_creditcard_form.dart';
import 'package:practice/pages/find_suitable_cards.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '信用卡推坑系統',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: new NewCreditCardForm(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/newCard': (context) => new NewCreditCardForm(),
        '/find_suitable_cards': (context) => new FindSuitableCards(),
      },
    );
  }
}
