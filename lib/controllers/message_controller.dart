import 'package:messenger_bloc/data/models/message_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MessageController {
  final Map<String, List<MessageModel>> _allMessages = {
    "1-10": [
      MessageModel(
        createdTime: "2024-03-25 20:41:11.366752",
        messageText: "Vazifa nima bo'ldi alisher?",
        messageId: "1",
        isFile: false,
        contactId: 1,
        status: true,
      ),
      MessageModel(
        createdTime: "2024-04-20 20:41:11.366752",
        messageText:
            "https://bilimlar.uz/wp-content/uploads/2021/02/k100001.pdf",
        messageId: "2",
        isFile: true,
        contactId: 1,
        status: true,
      ),
    ]
  };

  List<MessageModel> getMessages(String reciverId) {
    try {
      return [..._allMessages["$reciverId-10"]!];
    } catch (e) {
      return [];
    }
  }

  void sendMessage(MessageModel message, String reciverId) {
    final messageData = MessageModel(
        createdTime: message.createdTime,
        messageText: message.messageText,
        messageId: message.messageId,
        isFile: message.isFile,
        contactId: message.contactId,
        status: message.status);
    _allMessages.containsKey("$reciverId-10")
        ? _allMessages["$reciverId-10"]!.add(messageData)
        : _allMessages["$reciverId-10"] = [messageData];
  }

  Future<void> openIfFile(String reciverId, String messageId) async {
    try {
      final messages = _allMessages["$reciverId-10"];
      if (messages != null) {
        final message =
            messages.firstWhere((msg) => msg.messageId == messageId);
        if (message.isFile) {
          String url = message.messageText;
          if (await canLaunchUrlString(url)) {
            await launchUrlString(url);
          } else {
            print("Could not launch $url");
          }
        } else {
          print("Message is not a file.");
        }
      }
    } catch (e) {
      print("Error opening file: $e");
    }
  }
}
