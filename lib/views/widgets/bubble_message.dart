import 'package:flutter/material.dart';

class BubbleMessage extends StatelessWidget {
  final String userName;
  final String message;
  final bool isMe;
  final String image;

  const BubbleMessage({
    required this.image,
    required this.userName,
    required this.message,
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        !isMe
            ? CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: !isMe ? Radius.zero : const Radius.circular(14),
                bottomRight: isMe ? Radius.zero : const Radius.circular(14),
              )),
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
        isMe
            ? CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(image),
              )
            : Container(),
      ],
    );
  }
}
