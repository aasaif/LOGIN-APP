import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/my_button.dart';
import '../component/my_textfield.dart';
import '../component/square_tile.dart';
import '../controller/auth_controller.dart';
import '../core/helper/validator.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SizedBox(height: 50),

            // logo
            /*const Icon(
              Icons.lock,
              size: 100,
            ),*/
            Container(
              height: 300,
              width: 400,
              child: Image.asset(
                "lib/images/login.png",
              ),
            ),

            const SizedBox(height: 10),

            // welcome back, you've been missed!
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  'Login Details',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // username textfield
            MyTextField(
              controller: emailController,
              hintText: 'Username,email & phone number',
              obscureText: false,
              validator: (v) => Validator.validateEmail(v!),
            ),

            const SizedBox(height: 10),

            // password textfield
            MyTextField(controller: passwordController, hintText: 'Password', obscureText: true),

            const SizedBox(height: 10),

            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // sign in button
            MyButton(
              onTap: () {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  authController.login(email: emailController.text.trim(), password: passwordController.text.trim());
                }
              },
            ),

            const SizedBox(height: 50),

            // or continue with
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Or signup with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // google + apple sign in buttons
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // google button
                SquareTile(imagePath: 'lib/images/google.png'),

                SizedBox(width: 25),

                // apple button
                SquareTile(imagePath: 'lib/images/apple.png')
              ],
            ),

            const SizedBox(height: 20),

            // not a member? register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member?',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
