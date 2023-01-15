import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/khat_model.dart';
import '../../services/db_service.dart';

class gifs extends StatefulWidget {
  const gifs({super.key, required this.content});
  final String content;
  @override
  State<gifs> createState() => _gifsState();
}

class _gifsState extends State<gifs> {
  int gifcase = 0;
  String pigeon = "assets/images/pigeon.jpg";
  String balloon = "assets/images/balloon.jpg";
  String bottle = "assets/gifs/bottle.gif";
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
      child: gifcase > 2
          ? pigeon_gif()
          : gifcase == 2
              ? balloon_gif()
              : gifcase == 1
                  ? bottle_gif()
                  : Column(
                      children: [
                        Container(height: h * 0.37),
                        Container(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: InkWell(
                                  child: Container(
                                    height: h * 0.11,
                                    width: w * 0.23,
                                    decoration: BoxDecoration(
                                      //border radius
                                      border: Border.all(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(pigeon),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      gifcase = 3;
                                      pigeon = "assets/images/pigeon.jpg";
                                    });
                                    final ids =
                                        await DBService().getInterestsIds();
                                    final _random = Random();
                                    final id = ids[_random.nextInt(ids.length)];
                                    final khat = KhatModel(
                                        createdAt: DateTime.now()
                                            .microsecondsSinceEpoch
                                            .toString(),
                                        content: widget.content,
                                        senderId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        receiverId: id);
                                    await DBService()
                                        .sendKhat(khat)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text('Khat sent')));
                                      Navigator.pop(context);
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: InkWell(
                                  child: Container(
                                    height: h * 0.11,
                                    width: w * 0.23,
                                    decoration: BoxDecoration(
                                      //border radius
                                      border: Border.all(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(balloon),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      gifcase = 2;

                                      balloon = "assets/images/balloon.jpg";
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: InkWell(
                                  child: Container(
                                    height: h * 0.11,
                                    width: w * 0.23,
                                    decoration: BoxDecoration(
                                      //border radius
                                      border: Border.all(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                      borderRadius: BorderRadius.circular(30),
                                      image: DecorationImage(
                                          image: AssetImage(bottle),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      gifcase = 1;
                                      bottle = "assets/images/bottle.jpg";
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
    ));
  }

  Widget pigeon_gif() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Container(
            height: h * 0.2,
          ),
          Container(
            height: h * 0.5,
            width: w * 0.9,
            decoration: BoxDecoration(
              //border radius
              image: DecorationImage(
                  image: AssetImage("assets/gifs/pigeon.gif"),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget balloon_gif() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/gifs/balloon.gif"), fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget bottle_gif() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Container(
            height: h * 0.05,
          ),
          Container(
            height: h * 0.8,
            width: w * 0.9,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              image: DecorationImage(
                  image: AssetImage("assets/gifs/bottle.gif"),
                  fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }
}
