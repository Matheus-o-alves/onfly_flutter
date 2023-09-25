import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onfly_flutter/ui/pages/login/login.presenter.dart';

class LoginPage extends StatefulWidget {
  final LoginPagePresenter presenter;

  const LoginPage({Key? key, required this.presenter}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.presenter.navigateToStream.listen((page) {
      if (page?.isNotEmpty == true) {
        Get.offAllNamed(page!,
            arguments: widget.presenter.navigationHomePage());
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.airplanemode_active,
                  color: Colors.white,
                  size: 120,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'ONFLY',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'usuário',
                    hintText: 'Informe seu usuário',
                    prefixIcon: const Icon(Icons.email, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: 'Informe sua senha',
                    prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final email = emailController.text;
                  final password = passwordController.text;
                  widget.presenter.loginWithEmailAndPassword(email, password);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                final error = widget.presenter.error.value;
                return error != null
                    ? Text(
                        error,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
