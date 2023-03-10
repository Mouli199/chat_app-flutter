import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../chat/message.dart';
import '../chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme
                    .of(context)
                    .primaryIconTheme
                    .color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'Logout',
                ),
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: Container(child: Column(children: <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],),),
        // StreamBuilder(
        //   stream: FirebaseFirestore.instance
        //       .collection('chats/GCsf87XWuB9CHSm87DJA/messages')
        //       .snapshots(),
        //   builder: (ctx, streamSnapshot) {
        //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     final documents = streamSnapshot.data!.docs;
        //     return ListView.builder(
        //       itemCount: streamSnapshot.data!.docs.length,
        //       itemBuilder: (ctx, index) => Container(
        //         padding: EdgeInsets.all(10),
        //         child: Text(documents[index]['text']),
        //       ),
        //     );
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: () {
    FirebaseFirestore.instance
        .collection('chats/GCsf87XWuB9CHSm87DJA/messages')
        .add({'text': 'This was added by clicking the button!'});
    },
    )
    ,
    );
  }
}
