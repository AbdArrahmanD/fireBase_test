import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/bubble_message.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy('timeStamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
            ],
          );
        }
        debugPrint(snapshot.hasData
            ? 'snapshot.data : ${snapshot.data}'
            : 'snapShot does NOT has any data');
        final docs = snapshot.hasData ? snapshot.data!.docs : [];
        final currentUser = FirebaseAuth.instance.currentUser;

        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) => BubbleMessage(
            userName: docs[index]['userName'],
            message: docs[index]['text'],
            isMe: docs[index]['userId'] == currentUser?.uid,
            key: ValueKey(docs[index].id),
            image: docs[index]['image'],
          ),
        );
      },
    );
  }
}
