import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: progress == 1
              ? namePage()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: const Text(
                        'Create Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Form(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            TextField(
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
                                fillColor:
                                    const Color.fromARGB(255, 69, 194, 73)
                                        .withOpacity(0.7),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
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
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                obscureText: true,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  hintText: 'Confirm Password',
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
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SizedBox(
                                height: 40,
                                width: 68,
                                child: MaterialButton(
                                  color: const Color.fromARGB(255, 66, 14, 179),
                                  onPressed: () {
                                    setState(() {
                                      progress++;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Text(
                                    '>>>',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            )
                            // DropdownButton(items: const [
                            //   DropdownMenuItem(child: Text('Male')),
                            //   DropdownMenuItem(child: Text('Female')),
                            //   DropdownMenuItem(child: Text('Others')),
                            // ], onChanged: ((value) {

                            // })),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  Widget genderPage() {
    return Column(
      children: const [],
    );
  }

  Widget namePage() {
    return Column(
      children:  [
        SizedBox(
          height: 100,
        ),
        Container(
          child: Text(
            'Name is the game,',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        Text(
          'love is the prize.',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500
          ),
          ),
      ],
    );
  }
}
