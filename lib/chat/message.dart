// import 'package:chat_app/chat/message_bubble.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Messages extends StatelessWidget {
//   const Messages({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       //future: FirebaseAuth.instance.currentUser(),
//       builder: (ctx, futureSnapshot) {
//     if (futureSnapshot.connectionState == ConnectionState.waiting) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//         return   StreamBuilder(
//             stream: FirebaseFirestore.instance.collection('chats').snapshots(),
//             builder: (ctx, chatSnapshot) {
//               if (chatSnapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               final chatDocs = chatSnapshot.data.documents;
//               return ListView.builder(
//                   reverse: true,
//                   itemCount: chatDocs.length,
//                   itemBuilder: (ctx, index) =>
//                       MessageBubble(
//                         chatDocs[index]['text'],
//                         chatDocs[index]['userId'] == futureSnapshot.data?.uid,
//                         key: ValueKey(chatDocs[index].documentID),
//                       ),
//                   // Text(chatDocs[index]['text']
//                 );
//             });
//         // );
//       },
//     );
//   }
// }
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy(
              'createdAt',
              descending: true,
            )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data!.docs;

              return ListView.builder(
                reverse: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => MessageBubble(

                  message: chatDocs[index]['text'],
                  userImage: chatDocs[index]['userImage'],
                  userName: chatDocs[index]['userName'],
                  isMe: true,

                ),
              );
            });
      },
    );
  }
}