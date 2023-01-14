import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';


class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _formKey2 = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // child:SingleChildScrollView(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.2,
                width: w * 0.9,
                // color: Colors.grey,
              ),
              Container(
                height: h * 0.15,
                width: w * 0.9,
                // color: Colors.grey,
                child: Text(
                  'Hey, \n Login Now.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              //  Container(
              //   height: h * 0.6,
              //   color: Colors.black12,
              //   child: Text('Create New Account'),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 8),
                child: Row(
                  children: [
                    Text(
                      'If you are new / ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      //  color: Color.fromARGB(255, 14, 179, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Create New', //link to sign in screen
                        style: TextStyle(
                          color: Colors.black,
                          // Color.fromARGB(255, 65, 186, 69).withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: h * 0.03,
                width: w * 0.9,
                // color: Colors.grey,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        }
                        return null;
                      },
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        contentPadding: const EdgeInsets.all(18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        obscureText: true,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                          ),
                          contentPadding: const EdgeInsets.all(18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 0),
                child: Row(
                  children: [
                    Text(
                      'Forget Passcode? / ',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.4),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      //  color: Color.fromARGB(255, 14, 179, 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Reset', //link to sign in screen
                        style: TextStyle(
                          color: Colors.black,
                          // Color.fromARGB(255, 65, 186, 69).withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: 50,
                  width: w * 0.9,
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 66, 14, 179),
                    onPressed: () {
                      // setState(() {
                      //   // progress++;
                      // });
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
