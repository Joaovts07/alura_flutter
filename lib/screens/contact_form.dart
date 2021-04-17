import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatefulWidget {
  final Contact contact;

  ContactForm(this.contact);

  @override
  _ContactFormState createState() => _ContactFormState(contact);
}

class _ContactFormState extends State<ContactForm> {
  Contact contact;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final ContactDao _contactDAO = ContactDao();

  _ContactFormState(this.contact);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: contact == null ?  Text('New contact') : Text('Edit contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: contact == null ? 'Full name' : contact.name,
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
                  labelText: contact == null ? 'Account number': contact.accountNumber,
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
                  child: Text('Create'),
                  onPressed: () {
                    final String name = _nameController.text;
                    final String accountNumber =
                        _accountNumberController.text.toString();
                    final Contact newContact = Contact(0, name, accountNumber);
                    _contactDAO
                        .save(newContact)
                        .then((id) => Navigator.pop(context));
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
