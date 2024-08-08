import 'package:flutter/material.dart';
import 'package:messenger_bloc/controllers/contact_controller.dart';
import 'package:messenger_bloc/data/models/contact_model.dart';
import 'package:messenger_bloc/ui/screens/chat_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ContactController contactController = ContactController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: contactController.getContacts.length,
        itemBuilder: (ctx, index) {
          ContactModel contact = contactController.getContacts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(contact.imageUrl),
            ),
            title: Text("${contact.contactName} ${contact.contactLasName}"),
            subtitle: Text(contact.phone),
            trailing: const Text("time"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ChatScreen(
                    contact: contact,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
