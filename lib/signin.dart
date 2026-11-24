
import 'package:flutter/material.dart';
import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final pinController = TextEditingController();

  bool hidePin = true;
  String message = '';

  @override
  void dispose() {
    idController.dispose();
    pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Sign In'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            children: [

              const SizedBox(height: 20),

              // Library Logo
              const CircleAvatar(
                radius: 55,
                backgroundImage:
                    AssetImage('assets/library_logo.png'),
              ),

              const SizedBox(height: 20),

              // Heading
              Text(
                'Welcome to UniLibrary',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade800,
                ),
              ),

              const SizedBox(height: 30),

              // Student ID Field
              TextFormField(
                controller: idController,

                decoration: InputDecoration(
                  labelText: 'Student ID',
                  hintText: 'e.g. BSIT-F23-M-01',

                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.teal.shade700,
                  ),

                  filled: true,
                  fillColor: Colors.teal.shade50,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Student ID is required';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // PIN Field
              TextFormField(
                controller: pinController,
                obscureText: hidePin,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                  labelText: 'PIN',
                  hintText: 'Enter 4-digit PIN',

                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.teal.shade700,
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(
                      hidePin
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),

                    onPressed: () {
                      setState(() {
                        hidePin = !hidePin;
                      });
                    },
                  ),

                  filled: true,
                  fillColor: Colors.teal.shade50,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.length < 4) {
                    return 'PIN must be at least 4 digits';
                  }

                  if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                    return 'PIN must contain digits only';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  // Sign In Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    onPressed: () async {
                      if (formKey.currentState!.validate()) {

                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(
                              studentId: idController.text.trim(),
                            ),
                          ),
                        );

                        if (!mounted) return;

                        if (result != null) {
                          setState(() {
                            message = result.toString();
                            idController.clear();
                            pinController.clear();
                            hidePin = true;
                          });
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) {
                              setState(() {
                                message = '';
                              });
                            }
                          });
                        }
                      }
                    },

                    child: const Text('Sign In'),
                  ),

                  const SizedBox(width: 20),

                  // Register Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    onPressed: () {},

                    child: const Text('Register'),
                  ),
                ],
              ),

              // Forgot PIN
              TextButton(
                onPressed: () {},
                child: const Text('Forgot PIN?'),
              ),

              const SizedBox(height: 15),

              // Sign Out Message
              Text(
                message,
                style: TextStyle(
                  color: Colors.teal.shade800,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
