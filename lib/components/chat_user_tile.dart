import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserTile extends StatelessWidget {
  const ChatUserTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: const ListTile(
          title: Text('Unknown'),
          leading: Icon(CupertinoIcons.profile_circled),
          subtitle: Text('StarChat'),
          ),
      ),
    );
  }
}