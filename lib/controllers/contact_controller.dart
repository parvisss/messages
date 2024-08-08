import 'package:messenger_bloc/data/models/contact_model.dart';

class ContactController {
  final List<ContactModel> _allContacts = [
    ContactModel(
      phone: '+998(97)747-77-94',
      contactId: 1,
      contactLasName: "Alisher",
      contactName: "Falonchiyev",
      isOnline: true,
      imageUrl:
          "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
      lastOnlineTime: DateTime.now(),
    )
  ];

  List<ContactModel> get getContacts {
    return [..._allContacts];
  }
}
