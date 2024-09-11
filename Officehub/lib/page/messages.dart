import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Officehub/page/chat.dart';
import 'package:intl/intl.dart'; // Add this for date formatting

class Messages extends StatefulWidget {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  Messages(
      {Key? key,
      FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        super(key: key);

  @override
  State<Messages> createState() => _Messages();
}

class _Messages extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: widget.firebaseFirestore.collection('users').snapshots(),
      builder: (context, snapshot) {
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
      },
    );
  }

  //build user item
  Widget _buildUserItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    if (data['uid'] != widget.firebaseAuth.currentUser!.uid) {
      return FutureBuilder<DocumentSnapshot?>(
        future: _fetchLatestMessage(data['uid']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Card(
              child: Container(
                height: 80,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return Container(); // Do not show the card if there's an error or no data
          }

          Map<String, dynamic>? messageData =
              snapshot.data?.data() as Map<String, dynamic>?;
          if (messageData == null) {
            return Container(); // Do not show the card if message data is null
          }

          String latestMessage = messageData['message'];
          Timestamp timestamp = messageData['timestamp'];
          String formattedTime =
              DateFormat('hh:mm a').format(timestamp.toDate());

          return GestureDetector(
            child: Card(
              child: Container(
                height: 80, // Set the height to twice the default
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                            'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/indizone/2021/08/02/d5soREV/video-klip-rick-roll-dari-rick-astley-sudah-ditonton-1-miliar-kali-di-youtube55.jpg'),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['displayName'],
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  latestMessage,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
        },
      );
    } else {
      return Container();
    }
  }

  Future<DocumentSnapshot?> _fetchLatestMessage(String receiverId) async {
    final String currentUserId = widget.firebaseAuth.currentUser!.uid;
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    QuerySnapshot querySnapshot = await widget.firebaseFirestore
        .collection('chatrooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }
}
