import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:midknight_helios/models/chat_model.dart';
import 'package:midknight_helios/models/khat_model.dart';
import 'package:midknight_helios/screens/khat_page/khat_page.dart';
import 'package:midknight_helios/services/chat_service.dart';
import 'package:midknight_helios/services/db_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: DBService().getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.blue),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: snapshot.data!.url,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const KhatPage(),
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SizedBox(
                              height: 60,
                              width: 130,
                              child: MaterialButton(
                                color: const Color.fromARGB(255, 66, 14, 179),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Text(
                                  'Write Khat',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 150,
                        ),
                        Container(
                          height: 100,
                          child: StreamBuilder<
                                  QuerySnapshot<Map<String, dynamic>>>(
                              stream: DBService().getKhats(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                        '${snapshot.error} occurred',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    );

                                    // if we got our data
                                  } else if (snapshot.hasData) {
                                    QuerySnapshot<Map<String, dynamic>>
                                        querySnapshot = snapshot.data!;
                                    List<KhatModel> khats =
                                        querySnapshot.docs.map((e) {
                                      return KhatModel.fromJson(e.data());
                                    }).toList();
                                    return Row(
                                      children: [
                                        ...List.generate(khats.length, (index) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('assets/images/scroll.png')
                                                  ),
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  }
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Chats',
          icon: Icon(Icons.chat),
        ),
      ]),
    );
  }
}
