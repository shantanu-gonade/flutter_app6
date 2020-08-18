import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app6/widgets/chat/messages.dart';
import 'package:flutter_app6/widgets/chat/new_message.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ChatScreen extends StatefulWidget {
  // Building the Chat Screen here
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      print(msg);
      return;
    }, onLaunch: (msg) {
      print(msg);
      return;
    }, onResume: (msg) {
      print(msg);
      return;
    });
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NeumorphicColors.background,
      appBar: NeumorphicAppBar(
        color: NeumorphicColors.background,
        centerTitle: true,
        title: NeumorphicText(
          'BBC Chat',
          textAlign: TextAlign.center,
          style: NeumorphicStyle(
            depth: 4,
            //customize depth here
            color: NeumorphicColors.decorationWhiteColor(
              Colors.blue[400],
              intensity: 0.8,
            ), //customize color here
            lightSource: LightSource.topLeft,
          ),
          textStyle: NeumorphicTextStyle(
            fontSize: 22, //customize size here
            fontWeight: FontWeight.w600,
            // AND others usual text style properties (fontFamily, fontWeight, ...)
          ),
        ),
        actions: [
          NeumorphicButton(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: NeumorphicIcon(
                Icons.power_settings_new,
                style: NeumorphicStyle(color: NeumorphicColors.accent),
                size: 32,
              ),
            ),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
              color: NeumorphicColors.background,
              shape: NeumorphicShape.convex,
              lightSource: LightSource.topLeft,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          // DropdownButton(

          //   items: [
          //     DropdownMenuItem(
          //       child: Neumorphic(
          //         child: Row(
          //           children: <Widget>[
          //             NeumorphicIcon(Icons.exit_to_app),
          //             SizedBox(
          //               width: 8,
          //             ),
          //             Text('Logout'),
          //           ],
          //         ),
          //       ),
          //       value: 'logout',
          //     ),
          //   ],
          //   onChanged: (itemIdentifier) {
          //     if (itemIdentifier == 'logout') {
          //       FirebaseAuth.instance.signOut();
          //     }
          //   },
          //   icon: Icon(
          //     Icons.more_vert,
          //     color: Theme.of(context).primaryIconTheme.color,
          //   ),
          // )
        ],
        // actions: <Widget>[
        //   DropdownButton(
        //     underline: Container(),
        //     items: [
        //       DropdownMenuItem(
        //         child: Neumorphic(
        //           child: Row(
        //             children: <Widget>[
        //               NeumorphicIcon(Icons.exit_to_app),
        //               SizedBox(
        //                 width: 8,
        //               ),
        //               Text('Logout'),
        //             ],
        //           ),
        //         ),
        //         value: 'logout',
        //       ),
        //     ],
        //     onChanged: (itemIdentifier) {
        //       if (itemIdentifier == 'logout') {
        //         FirebaseAuth.instance.signOut();
        //       }
        //     },
        //     icon: Icon(
        //       Icons.more_vert,
        //       color: Theme.of(context).primaryIconTheme.color,
        //     ),
        //   )
        // ],
      ),

      // AppBar(
      //   title: Text('Flutter Chat'),
      //   actions: <Widget>[
      //     DropdownButton(
      //       underline: Container(),
      //       items: [
      //         DropdownMenuItem(
      //           child: Neumorphic(
      //             child: Row(
      //               children: <Widget>[
      //                 Icon(Icons.exit_to_app),
      //                 SizedBox(
      //                   width: 8,
      //                 ),
      //                 Text('Logout'),
      //               ],
      //             ),
      //           ),
      //           value: 'logout',
      //         ),
      //       ],
      //       onChanged: (itemIdentifier) {
      //         if (itemIdentifier == 'logout') {
      //           FirebaseAuth.instance.signOut();
      //         }
      //       },
      //       icon: Icon(
      //         Icons.more_vert,
      //         color: Theme.of(context).primaryIconTheme.color,
      //       ),
      //     )
      //   ],
      // ),
      body: Neumorphic(
        style: NeumorphicStyle(
          color: NeumorphicColors.background,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
