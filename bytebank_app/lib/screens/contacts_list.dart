import 'package:bytebank_app/components/progress.dart';
import 'package:bytebank_app/database/dao/contact_dao.dart';
import 'package:bytebank_app/models/contact.dart';
import 'package:bytebank_app/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'contact_form.dart';

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
        title: Text('Transfer'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List(),
        future: widget.dao.findAll(),
        builder: (context, snapshoot) {
          switch (snapshoot.connectionState) {
            case ConnectionState.waiting:
              return Progress();

            case ConnectionState.done:
              final List<Contact> contacts = snapshoot.data;
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact, onClick: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return TransactionForm(contact);
                        }
                    ));
                  });
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
  final Function onClick;

  _ContactItem(this._contact, { @required this.onClick });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onClick(),
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