import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    CircleAvatar(
                      radius: 25,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),),
          BottomNavigationBarItem(
            label: 'Chats',
            icon: Icon(Icons.chat),),
      ]),
    );
  }
}