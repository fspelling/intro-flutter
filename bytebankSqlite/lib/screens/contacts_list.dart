import 'package:bytebankSqlite/models/contact.dart';
import 'package:bytebankSqlite/screens/contact_form.dart';
import 'package:bytebankSqlite/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  final ContactDao dao = ContactDao();

  @override
  State<StatefulWidget> createState() => ContactsListState();
}

class ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: widget.dao.findAll(),
        builder: (context, snapshoot) {
          switch (snapshoot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('loading')
                  ],
                ),
              );

            case ConnectionState.done:
              final List<Contact> contacts = snapshoot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact);
                },
              );
          }

          return null;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ContactForm()
          )).then((value) {
            setState(() { });
          });
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact _contact;

  _ContactItem(this._contact);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          _contact.fullName,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          _contact.account.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}