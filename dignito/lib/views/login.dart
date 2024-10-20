import 'package:flutter/material.dart';
import 'package:dignito/components/button.dart';
import 'package:dignito/components/input_field.dart';
import 'package:get/get.dart';
import 'package:dignito/controllers/login_controller.dart';
import 'package:dignito/custom_colors.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController loginCtrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              const Color(0xFFd02adb).withOpacity(0.8), // Darker shade with opacity
              const Color(0xFF271C22), // Dark background color
            ],
            center: Alignment.topCenter,
            radius: 0.8, // Adjusted for a more subtle effect
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0), // Adjust padding as needed
                    child: Image.asset(
                      'assets/logo.png', // Update this path to your logo
                      height: 200, // Increased height for a bigger logo
                      fit: BoxFit.contain, // Maintain aspect ratio
                    ),
                  ),

                  SizedBox(
                    height: constraints.maxHeight * 0.05, // Space from the logo
                  ),

                  // Username Input Field
                  InputField(
                    labelText: 'Username',
                    icon: Icons.person,
                    initialValue: '', // Default initial value
                    onPressedCallback: loginCtrl.clearErrorMsg,
                    readOnly: false,
                    controller: loginCtrl.usernameCtrl,
                  ),

                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),

                  // Password Input Field
                  InputField(
                    labelText: 'Password',
                    icon: Icons.lock,
                    initialValue: '', // Default initial value
                    onPressedCallback: loginCtrl.clearErrorMsg,
                    readOnly: false,
                    controller: loginCtrl.passwordCtrl,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),

                  // Error Message
                  SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: GetBuilder<LoginController>(
                      builder: (controller) {
                        return Text(
                          loginCtrl.errorMsg,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),

                  // Login Button
                  button(
                    'Login',
                    loginCtrl.validateInputs,
                    CustomColors.DigPink,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.02,
                  ),

                  const Text(
                    'Powered by dist',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
