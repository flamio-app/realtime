import 'package:flutter/material.dart';
import '../services/appwrite_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AppwriteService _appwrite = AppwriteService();

  bool _loading = false;
  String? _error;

  void _register() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await _appwrite.createUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _loading = false;
      });

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Kayıt Başarılı'),
          content: Text('Hesabınız başarıyla oluşturuldu.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tamam'),
            ),
          ],
        ),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_error != null) ...[
              Text(_error!, style: TextStyle(color: Colors.red)),
              SizedBox(height: 10),
            ],
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre'),
            ),
            SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _register,
              child: Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
