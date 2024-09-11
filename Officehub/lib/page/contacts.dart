import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/page/chat.dart';

class Contact extends StatefulWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Contact(
      {Key? key,
      FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        super(key: key);

  @override
  State<Contact> createState() => _Contact();
}

class _Contact extends State<Contact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Color(0xFFF8964F), // Set the background color
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          actions: [
            //Icon(Icons.phone, color: Colors.white),
            SizedBox(
              width: 10,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: widget.firebaseFirestore.collection('users').snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((docs) => _buildUserItem(docs))
                .toList(),
          );
        }));
  }

  //build user item
  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (data['uid'] != widget.firebaseAuth.currentUser!.uid) {
      return GestureDetector(
        child: Card(
          child: Container(
            height: 80, // Set the height to twice the default
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/indizone/2021/08/02/d5soREV/video-klip-rick-roll-dari-rick-astley-sudah-ditonton-1-miliar-kali-di-youtube55.jpg'),
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  data['displayName'],
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverId: data['uid'],
                receiverUserName: data['displayName'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
