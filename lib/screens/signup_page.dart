import 'package:flutter/material.dart';
import 'package:to_do_app_firebase/data/auth_data.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback show;
  const SignupPage({super.key, required this.show});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();
  final PasswordConfirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });

    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              image(),
              const SizedBox(height: 50),
              textfield(email, _focusNode1, 'Email', Icons.email),
              const SizedBox(height: 10),
              textfield(password, _focusNode2, 'password', Icons.password),
              const SizedBox(height: 10),
              textfield(PasswordConfirm, _focusNode3, 'Confirm password', Icons.password),
              const SizedBox(height: 8),
              account(),
              const SizedBox(height: 20),
              signUpBotton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Have an account ?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          const SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: widget.show,
            child: const Text(
              'Login',
              style: TextStyle(color: Color.fromARGB(255, 39, 218, 173), fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUpBotton() {
    return GestureDetector(
      onTap: () {
        AuthRemote().register(email.text, password.text, PasswordConfirm.text);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 39, 218, 173),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield(TextEditingController _controller, FocusNode _foucsNode, String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _foucsNode,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: _foucsNode.hasFocus ? const Color.fromARGB(255, 39, 218, 173) : Colors.grey,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Color.fromARGB(31, 34, 185, 150),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: 300,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/5.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
