import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final Contact contact;

  ContactForm({this.contact});

  @override
  _ContactFormState createState() => _ContactFormState(contact);
}

class _ContactFormState extends State<ContactForm> {
  Contact contact;
  TextEditingController _nameController;
  TextEditingController _accountNumberController;

  final ContactDao _contactDAO = ContactDao();
  _ContactFormState(this.contact) {
    if(contact != null){
      _nameController   =
          TextEditingController(text: contact.name);
      _accountNumberController =
          TextEditingController(text: contact.accountNumber);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText:  'Full name',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Account number',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  child: contact == null ? Text('Create') : Text('Update'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final String accountNumber =
                    _accountNumberController.text.toString();
                    if (contact == null) {
                      final Contact newContact =
                      Contact(0, name, accountNumber);
                      _contactDAO
                          .save(newContact)
                          .then((id) => Navigator.pop(context));
                    } else {
                      final Contact newContact =
                      Contact(contact.id, name, accountNumber);
                      _contactDAO
                          .update(newContact)
                          .then((id) => Navigator.pop(context));
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
