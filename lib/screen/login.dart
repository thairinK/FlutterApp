import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  String email = '', password = '';
  bool loading = false;

  void _login() async {
    if (!_form.currentState!.validate()) return;
    setState(() => loading = true);

    final res = await ApiService.login(email, password);
    if (!mounted) return;
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Login')),
    body: Padding(padding: const EdgeInsets.all(16),
      child: Form(key: _form, child: Column(children: [
        TextFormField(decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (v) => email = v,
          validator: (v) => v != null && v.contains('') ? null : 'กรุณาอีเมล'),
        TextFormField(decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true, onChanged: (v) => password = v,
          validator: (v) => v != null && v.length >= 6 ? null : 'รหัสผ่านสั้นเกินไป'),
        const SizedBox(height: 20),
        loading ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _login, child: const Text('Login')),
        TextButton(onPressed: () => Navigator.push(c,
          MaterialPageRoute(builder: (_) => const RegisterScreen())),
          child: const Text('สมัครสมาชิก'))
      ]))),
  );
}
