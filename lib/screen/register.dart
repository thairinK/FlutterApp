import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  String name = '', email = '', password = '';
  bool loading = false;

  void _submit() async {
    if (!_form.currentState!.validate()) return;
    setState(() => loading = true);

    final res = await ApiService.register(name, email, password);
    if (!mounted) return;
    setState(() => loading = false);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'])));
    if (res['success']) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('Register')),
    body: Padding(padding: const EdgeInsets.all(16),
      child: Form(key: _form, child: Column(children: [
        TextFormField(decoration: const InputDecoration(labelText: 'Name'),
          onChanged: (v) => name = v,
          validator: (v) => v != null && v.isNotEmpty ? null : 'กรอกชื่อ'),
        TextFormField(decoration: const InputDecoration(labelText: 'Email'),
          onChanged: (v) => email = v,
          validator: (v) => v != null && v.contains('@') ? null : 'อีเมลไม่ถูกต้อง'),
        TextFormField(decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true, onChanged: (v) => password = v,
          validator: (v) => v != null && v.length >= 6 ? null : 'รหัสผ่านสั้นเกินไป'),
        const SizedBox(height: 20),
        loading ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _submit, child: const Text('Register')),
      ]))),
  );
}
