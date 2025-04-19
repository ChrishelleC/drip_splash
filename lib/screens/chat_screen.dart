import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  final String boardName;
  ChatScreen({required this.boardName});

  final messageController = TextEditingController();

  void sendMessage(String message) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance.collection('boards').doc(boardName).collection('messages').add({
      'message': message,
      'userId': user!.uid,
      'username': user.email,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(boardName)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('boards')
                  .doc(boardName)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final messages = snapshot.data!.docs;
                return ListView(
                  reverse: true,
                  children: messages.map((doc) {
                    return ListTile(
                      title: Text(doc['username'] ?? 'Anonymous'),
                      subtitle: Text(doc['message']),
                      trailing: Text(doc['timestamp']?.toDate().toString() ?? ''),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: TextField(controller: messageController)),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messageController.text);
                    messageController.clear();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}