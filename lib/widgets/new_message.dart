import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _newMessageController = TextEditingController();
  @override
  void dispose() {
    _newMessageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final enteredMessage = _newMessageController.text;

    if (enteredMessage.trim().isEmpty) {
      return;
    }
    _newMessageController.clear();

    final user = FirebaseAuth.instance.currentUser!;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImg': userData.data()!['img_url'],
      'createdAt': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 1, left: 15, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _newMessageController,
              decoration: const InputDecoration(
                labelText: 'Send a message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(80),
                  ),
                ),
              ),
              autocorrect: true,
              textCapitalization: TextCapitalization.sentences,
              enableSuggestions: true,
            ),
          ),
          IconButton(
              onPressed: _sendMessage,
              icon: Icon(
                Icons.send,
                color: Theme.of(context).colorScheme.primary,
              ))
        ],
      ),
    );
  }
}
