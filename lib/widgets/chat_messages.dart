import 'package:chaty/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No message found'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went worng'),
          );
        }
        final loadedMessages = snapshot.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 20, right: 20),
          reverse: true,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextMessage = (index + 1 < loadedMessages.length)
                ? loadedMessages[index + 1].data()
                : null;
            final currentMessageUid = chatMessage['userId'];
            final nextMessageUid =
                nextMessage != null ? nextMessage['userId'] : null;
            final bool nextUserIsSame = currentMessageUid == nextMessageUid;
            if (nextUserIsSame) {
              return MessageBubble.next(
                  message: chatMessage['text'],
                  isMe: authUser.uid == currentMessageUid);
            } else {
              return MessageBubble.first(
                  userImage: chatMessage['userImg'],
                  username: chatMessage['username'],
                  message: chatMessage['text'],
                  isMe: currentMessageUid == authUser.uid);
            }
          },
          itemCount: loadedMessages.length,
        );
      },
    );
  }
}
