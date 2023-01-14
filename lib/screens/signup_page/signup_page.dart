import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midknight_helios/models/user_model.dart';
import 'package:midknight_helios/screens/home_page/home_page.dart';
import 'package:midknight_helios/services/auth_service.dart';
import 'package:midknight_helios/services/db_service.dart';
import 'package:midknight_helios/services/local_storage.dart';
import 'package:midknight_helios/services/location_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  int progress = 0;
  bool isLoading = false;
  String? gender;
  String? interested;
  bool locationLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(25.0),
                child: progress > 2
                    ? profilePage()
                    : progress == 2
                        ? genderPage()
                        : progress == 1
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
                                    key: _formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: _emailController,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              hintText: 'Email',
                                              hintStyle: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.all(18),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide.none,
                                              ),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                      255, 69, 194, 73)
                                                  .withOpacity(0.7),
                                            ),
                                            validator: (value) {
                                              final emailValid = RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                                              if (value!.isEmpty) {
                                                return "Email is required";
                                              } else if (!emailValid
                                                  .hasMatch(value)) {
                                                return "Enter valid email";
                                              }
                                            },
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextFormField(
                                              controller: _passwordController,
                                              validator: (value) {
                                                String pattern =
                                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                                RegExp regExp = RegExp(pattern);
                                                if (value!.isEmpty) {
                                                  return "Please enter password";
                                                } else if (!regExp
                                                    .hasMatch(value)) {
                                                  return " At least 1 Uppercase letter and 1 Symbol required ";
                                                }
                                              },
                                              obscureText: true,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                hintText: 'Password',
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(18),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextFormField(
                                              controller:
                                                  _confirmPasswordController,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Enter Confirm Password";
                                                } else if (value !=
                                                    _passwordController.text) {
                                                  return "Password doesn't match";
                                                }
                                              },
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w500),
                                              decoration: InputDecoration(
                                                hintText: 'Confirm Password',
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(18),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide.none,
                                                ),
                                                filled: true,
                                                fillColor: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: SizedBox(
                                              height: 40,
                                              width: 68,
                                              child: MaterialButton(
                                                color: const Color.fromARGB(
                                                    255, 66, 14, 179),
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    setState(() {
                                                      progress++;
                                                    });
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: const Text(
                                                  '>>>',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
                                          ),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey2,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Row(
              children: [
                const Text(
                  'I am ',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.all(15.0),
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Gender',
                          fillColor: Colors.white,
                          filled: true),
                      elevation: 5,
                      value: gender,
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          value: "Male",
                          child: Text('Male'),
                        ),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text('Female'),
                        ),
                        DropdownMenuItem(
                          value: "Others",
                          child: Text('Others'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value;
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  children: [
                    const Text(
                      'Interested in ',
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.all(15.0),
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Gender',
                              fillColor: Colors.white,
                              filled: true),
                          elevation: 5,
                          value: interested,
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: "Male",
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: "Female",
                              child: Text('Female'),
                            ),
                            DropdownMenuItem(
                              value: "Both",
                              child: Text('Both'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              interested = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 40,
                width: 68,
                child: MaterialButton(
                  color: const Color.fromARGB(255, 66, 14, 179),
                  onPressed: () {
                    if (_formKey2.currentState!.validate()) {
                      setState(() {
                        progress++;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text(
                    '>>>',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePage() {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'The choice is yours ',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'to unveil the insight.',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 66, 14, 179),
                fontWeight: FontWeight.w500),
          ),
        ),
        Form(
            key: _formKey3,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (() async {
                      final _image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        _imageFile = _image;
                      });
                    }),
                    child: SizedBox(
                      height: 150,
                      child: CircleAvatar(
                        backgroundImage: _imageFile == null
                            ? null
                            : FileImage(File(_imageFile!.path)),
                        radius: 75,
                        backgroundColor: const Color.fromARGB(255, 65, 186, 69),
                        child: _imageFile == null
                            ? Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  'Upload Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 15),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Age is required";
                      }
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Age',
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Provide your location";
                      }
                    },
                    readOnly: true,
                    controller: _locationController,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Location',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: locationLoading
                            ? const CircularProgressIndicator()
                            : InkWell(
                                onTap: () async {
                                  setState(() {
                                    locationLoading = true;
                                  });
                                  Position p = await determinePosition();
                                  List<Placemark> placemarks =
                                      await placemarkFromCoordinates(
                                          p.latitude, p.longitude);
                                  setState(() {
                                    locationLoading = false;
                                    _locationController.text =
                                        '${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
                                  });
                                },
                                child: const Text(
                                  "Get Location",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 66, 14, 179),
                                  ),
                                ),
                              ),
                      ),
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
                      onPressed: () async {
                        if (_formKey3.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          if (_imageFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please Upload Image')));
                            return;
                          }
                          String? url = await DBService()
                              .uploadFile(File(_imageFile!.path));
                          if (url == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Something went wrong')));
                            return;
                          }
                          MyUser user = MyUser(
                              first_name: _firstController.text,
                              last_name: _lastController.text,
                              gender: gender!,
                              interested: interested!,
                              password: _passwordController.text,
                              url: url,
                              email: _emailController.text);
                          await AuthService().createUserWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                          localStorage.username = _emailController.text;
                          await DBService().createUser(user).then((value) {
                            setState(() {
                              isLoading = true;
                            });
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                              (r) => false,
                            );
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        '>>>',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }

  Widget namePage() {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'Name is the game,',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: const Text(
            'love is the prize.',
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 66, 14, 179),
                fontWeight: FontWeight.w500),
          ),
        ),
        Form(
            key: _formKey1,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 30, bottom: 15),
                  child: TextFormField(
                    controller: _firstController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Your First Name";
                      }
                    },
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'First name',
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
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: TextFormField(
                    controller: _lastController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Your Last Name";
                      }
                    },
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Last name',
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
                        if (_formKey1.currentState!.validate()) {
                          setState(() {
                            progress++;
                          });
                        }
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: const Text(
                        '>>>',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
