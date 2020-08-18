import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message,
    this.userName,
    this.userImage,
    this.isMe, {
    this.key,
  });
  final String userName;
  final Key key;
  final String message;
  final String userImage;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 200,
              child: Neumorphic(
                textStyle: TextStyle(
                  fontFamily: 'Product Sans',
                ),
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  lightSource: LightSource.topLeft,
                  color: isMe
                      ? NeumorphicColors.background
                      : NeumorphicColors.decorationWhiteColor(
                          Colors.blue[100],
                          intensity: 0.8,
                        ),
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft:
                          !isMe ? Radius.circular(0) : Radius.circular(12),
                      bottomRight:
                          isMe ? Radius.circular(0) : Radius.circular(12),
                    ),
                  ),
                ),
                // decoration: BoxDecoration(
                //   color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                //   borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(12),
                //     topRight: Radius.circular(12),
                //     bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                //     bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                //   ),
                // ),

                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      userName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline1.color,
                      ),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline1.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 180,
          right: isMe ? 180 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
