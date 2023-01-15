import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:midknight_helios/components/chat_user_tile.dart';
import 'package:midknight_helios/screens/chat_page/chat_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatPage(),
                            ));
                          },
                          child: ChatUserTile()),
                      ChatUserTile(),
                      ChatUserTile(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
