import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController mobileCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool hidePassword = true;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registered Successfully ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2193b0),
              Color(0xff6dd5ed),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1565C0),
                        ),
                      ),

                      const SizedBox(height: 25),

                      buildField(
                        controller: nameCtrl,
                        label: "Name",
                        icon: Icons.person,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name required";
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return "Only alphabets allowed";
                          }
                          return null;
                        },
                      ),

                      buildField(
                        controller: mobileCtrl,
                        label: "Mobile (+92XXXXXXXXXX)",
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Mobile required";
                          }
                          if (!RegExp(r'^\+92[0-9]{10}$').hasMatch(value)) {
                            return "Invalid mobile format";
                          }
                          return null;
                        },
                      ),

                      buildField(
                        controller: emailCtrl,
                        label: "Email",
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value!)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                      ),

                      buildField(
                        controller: passwordCtrl,
                        label: "Password",
                        icon: Icons.lock,
                        obscure: hidePassword,
                        suffix: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: const Color(0xff1E88E5),
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (!RegExp(r'^[a-zA-Z0-9]+$')
                              .hasMatch(value!)) {
                            return "Alphanumeric only";
                          }
                          return null;
                        },
                      ),

                      buildField(
                        controller: confirmCtrl,
                        label: "Confirm Password",
                        icon: Icons.lock_outline,
                        obscure: true,
                        validator: (value) {
                          if (value != passwordCtrl.text) {
                            return "Password not matched";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff1565C0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: submitForm,
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // 👈 white text
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xff1E88E5)),
          suffixIcon: suffix,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide:
            const BorderSide(color: Color(0xff1E88E5)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
