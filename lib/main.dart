import 'package:flutter/material.dart';
import 'screen/login.dart';
import 'screen/register.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    title: 'Auth Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    initialRoute: '/',
    routes: {
      '/': (c) => const LoginScreen(),
      '/register': (c) => const RegisterScreen(),
    },
  );
}
