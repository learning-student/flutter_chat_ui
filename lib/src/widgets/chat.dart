import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/src/models/message.dart';
import 'package:flutter_chat_ui/src/models/user.dart';
import 'package:flutter_chat_ui/src/widgets/inherited_user.dart';
import 'package:flutter_chat_ui/src/widgets/input.dart';
import 'package:flutter_chat_ui/src/widgets/message.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key key,
    @required this.messages,
    @required this.onSendPressed,
    @required this.user,
  })  : assert(messages != null),
        assert(onSendPressed != null),
        assert(user != null),
        super(key: key);

  final List<MessageModel> messages;
  final void Function(TextMessageModel) onSendPressed;
  final User user;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final messageWidth =
        min(MediaQuery.of(context).size.width * 0.77, 440).floor();

    return InheritedUser(
      user: widget.user,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus.unfocus(),
                child: ListView.builder(
                  itemCount: widget.messages.length,
                  padding: EdgeInsets.zero,
                  reverse: true,
                  itemBuilder: (context, index) {
                    final message = widget.messages[index];
                    // Update the logic after pagination is introduced
                    final isFirst = index == 0;
                    final previousMessage =
                        isFirst ? null : widget.messages[index - 1];

                    final previousMessageSameAuthor = previousMessage == null
                        ? false
                        : previousMessage.authorId == message.authorId;

                    return Message(
                      message: message,
                      messageWidth: messageWidth,
                      previousMessageSameAuthor: previousMessageSameAuthor,
                    );
                  },
                ),
              ),
            ),
            Input(
              onSendPressed: widget.onSendPressed,
            ),
          ],
        ),
      ),
    );
  }
}