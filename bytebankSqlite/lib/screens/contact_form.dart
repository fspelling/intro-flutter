import 'package:bytebankSqlite/database/dao/contact_dao.dart';
import 'package:bytebankSqlite/models/contact.dart';
import 'package:flutter/material.dart';

class ContactForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerFullName = TextEditingController();
    final TextEditingController _controllerAccount = TextEditingController();
    final ContactDao _dao = ContactDao();

    return Scaffold(
      appBar: AppBar(
        title: Text('New Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerFullName,
              decoration: InputDecoration(
                  labelText: 'Full Name'
              ),
              style: TextStyle(
                  fontSize: 24.0
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _controllerAccount,
                decoration: InputDecoration(
                    labelText: 'Acount'
                ),
                style: TextStyle(
                    fontSize: 24.0
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton(
                  onPressed: () {
                    final String fullName = _controllerFullName.text;
                    final int account = int.tryParse(_controllerAccount.text);
                    final Contact contact = Contact(0, fullName, account);

                    _dao.save(contact).then((id) => Navigator.pop(context));
                  },
                  child: Text('Confirmar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}