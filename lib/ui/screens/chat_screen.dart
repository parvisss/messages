import 'package:flutter/material.dart';
import 'package:messenger_bloc/controllers/message_controller.dart';
import 'package:messenger_bloc/data/models/contact_model.dart';
import 'package:messenger_bloc/data/models/message_model.dart';
import 'package:messenger_bloc/utils/date_time_utils.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.contact});
  final ContactModel contact;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController messageController = MessageController();

  final newMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.contact.contactName} ${widget.contact.contactLasName}"),
      ),
      body: ListView.builder(
        itemCount: messageController
            .getMessages(widget.contact.contactId.toString())
            .length,
        itemBuilder: (ctx, index) {
          final message = messageController
              .getMessages(widget.contact.contactId.toString())[index];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: message.contactId == widget.contact.contactId
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment:
                      message.contactId == widget.contact.contactId
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              topRight: const Radius.circular(20),
                              topLeft: const Radius.circular(20),
                              bottomRight:
                                  message.contactId == widget.contact.contactId
                                      ? const Radius.circular(20)
                                      : const Radius.circular(0),
                              bottomLeft:
                                  message.contactId == widget.contact.contactId
                                      ? const Radius.circular(0)
                                      : const Radius.circular(20)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(message.messageText),
                        ),
                      ),
                      onTap: () async {
                        await messageController.openIfFile(
                            widget.contact.contactId.toString(),
                            message.messageId);
                      },
                    ),
                  ],
                ),
                Text(
                  formatDateTime(message.createdTime),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextField(
          controller: newMessageController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            fillColor: Colors.amber,
            filled: true,
            suffixIcon: IconButton(
              onPressed: () {
                if (newMessageController.text.isNotEmpty) {
                  messageController.sendMessage(
                    MessageModel(
                        createdTime: DateTime.now().toString(),
                        messageText: newMessageController.text,
                        messageId: UniqueKey().toString(),
                        isFile: false,
                        contactId: -10,
                        status: false),
                    widget.contact.contactId.toString(),
                  );
                }
                newMessageController.text = "";
                setState(() {});
              },
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
