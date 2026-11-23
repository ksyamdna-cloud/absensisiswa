import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../pages/main_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _hide = true;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String hint, {Widget? suffix}) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 22, color: Colors.black87),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.fieldGrey,
        contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      );

  void _login() {
    // TODO: panggil API login dengan _userCtrl.text & _passCtrl.text
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const MainShell()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pink,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.vertical,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 60),
                const Text('SISTER SKANSIKA',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900)),
                const SizedBox(height: 30),
                const Icon(Icons.school_rounded, size: 160, color: AppColors.mauve),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.fromLTRB(36, 48, 36, 48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(56),
                  ),
                  child: Column(
                    children: [
                      TextField(
                          controller: _userCtrl,
                          decoration: _decoration('Masukan NIS  atau Username')),
                      const SizedBox(height: 36),
                      TextField(
                        controller: _passCtrl,
                        obscureText: _hide,
                        decoration: _decoration(
                          'Masukan Password',
                          suffix: IconButton(
                            icon: Icon(_hide ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black, size: 34),
                            onPressed: () => setState(() => _hide = !_hide),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,
                              shape: const StadiumBorder()),
                          onPressed: _login,
                          child: const Text('LOGIN',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}