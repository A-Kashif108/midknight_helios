import 'package:flutter/material.dart';
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
                            children: const [
                              CircleAvatar(
                                radius: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
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
