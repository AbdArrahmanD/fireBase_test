import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController controller = TextEditingController();
  String enteredText = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(hintText: 'Send a message...'),
              controller: controller,
              onChanged: (val) {
                setState(() {
                  enteredText = val;
                });
              },
            ),
          ),
          IconButton(
              onPressed: enteredText.trim().isNotEmpty ? sendMessage : null,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final currentUser = FirebaseAuth.instance.currentUser;
    print('currentUse $currentUser');
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();
    await FirebaseFirestore.instance.collection('chats').add({
      'text': enteredText,
      'timeStamp': Timestamp.now(),
      'userName': userData['userName'],
      'userId': currentUser?.uid,
      'image': userData['image'],
    });
    setState(() {
      enteredText = '';
    });
    controller.clear();
  }
}
