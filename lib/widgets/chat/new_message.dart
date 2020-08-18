import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    Firestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.flat,
        lightSource: LightSource.topLeft,
        color: NeumorphicColors.background,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
      ),
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -5,
                lightSource: LightSource.topLeft,
                color: NeumorphicColors.background,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(12),
                ),
              ),
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                enableSuggestions: true,
                autocorrect: true,
                decoration: InputDecoration(
                    labelText: 'Type your message here',
                    contentPadding: EdgeInsets.only(
                      left: 12,
                    )),
                onChanged: (value) {
                  setState(() {
                    _enteredMessage = value;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              lightSource: LightSource.topLeft,
              color: NeumorphicColors.background,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: IconButton(
              icon: NeumorphicIcon(
                Icons.send,
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  lightSource: LightSource.topLeft,
                  color: NeumorphicColors.accent,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
