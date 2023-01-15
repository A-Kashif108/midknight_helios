import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:midknight_helios/models/khat_model.dart';
import 'package:midknight_helios/services/db_service.dart';

class KhatPage extends StatefulWidget {
  const KhatPage({super.key, this.khat});
  final KhatModel? khat;

  @override
  State<KhatPage> createState() => _KhatPageState();
}

class _KhatPageState extends State<KhatPage> {
  TextEditingController contentController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final TextEditingController contentController = TextEditingController(
        text: widget.khat == null ? "" : widget.khat!.content);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/khat_paper.jpg"),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: h * 0.03,
                  width: w * 0.9,
                  // color: Colors.grey,
                ),
                Expanded(
                  child: TextField(
                      readOnly: widget.khat == null ? false : true,
                      controller: widget.khat == null
                          ? contentController1
                          : contentController,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                          hintText: 'Pour your feelings here.....',
                          hintStyle: TextStyle(
                            fontSize: 22,
                          ),
                          contentPadding: EdgeInsets.all(18),
                          border: InputBorder.none
                          // filled: true,
                          ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null),
                ),
                widget.khat == null
                    ? Padding(
                        padding: const EdgeInsets.all(23.0),
                        child: SizedBox(
                          height: 50,
                          width: w * 0.9,
                          child: MaterialButton(
                            onPressed: () async {
                              List<String> ids =
                                  await DBService().getInterestsIds();
                              final _random = Random();
                              final id = ids[_random.nextInt(ids.length)];
                              final khat = KhatModel(
                                  createdAt: DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString(),
                                  content: contentController1.text,
                                  senderId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  receiverId: id);
                              await DBService().sendKhat(khat).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Khat sent')));
                              });
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: const Text(
                              'SEND',
                              style: TextStyle(
                                  color: Color.fromARGB(219, 131, 85, 1),
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(23.0),
                            child: SizedBox(
                              height: 50,
                              width: 120,
                              child: MaterialButton(
                                onPressed: () {
                                  // setState(() {
                                  //   // progress++;
                                  // });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Release',
                                  style: TextStyle(
                                      color: Color.fromARGB(219, 255, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(23.0),
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: MaterialButton(
                                onPressed: () {
                                  // setState(() {
                                  //   // progress++;
                                  // });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Accept',
                                  style: TextStyle(
                                      color: Color.fromARGB(219, 148, 96, 1),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
