import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:Officehub/controllers/chat_controller.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverId;
  const ChatPage(
      {Key? key, required this.receiverUserName, required this.receiverId})
      : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService chatController = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      try {
        await chatController.sendMessage(
            widget.receiverId, _messageController.text);
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/indizone/2021/08/02/d5soREV/video-klip-rick-roll-dari-rick-astley-sudah-ditonton-1-miliar-kali-di-youtube55.jpg'),
            ),
            SizedBox(width: 16),
            Text(
              widget.receiverUserName,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ],
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
          Transform.rotate(
            angle: 3.14 / 2, // Rotate the icon by 90 degrees (in radians)
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
        stream: chatController.getMessages(
            widget.receiverId, _auth.currentUser!.uid),
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
                .map((document) => _buildMessageItem(document))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Align the message to the right if the sender is the current user, otherwise to the left
    bool isCurrentUser = data['senderId'] == _auth.currentUser!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    var backgroundColor = isCurrentUser ? Colors.blue[400] : Colors.grey[300];
    var textColor = isCurrentUser ? Colors.white : Colors.black;

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              data['message'],
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message',
                border: OutlineInputBorder(),
              ),
              obscureText: false,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}
