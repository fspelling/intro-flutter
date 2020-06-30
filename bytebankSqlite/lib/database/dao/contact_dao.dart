import 'package:bytebankSqlite/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class ContactDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY , '
      '$_fullname TEXT, '
      '$_account INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _fullname = 'fullname';
  static const String _account = 'account';

  Future<int> save(Contact contact) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contactMap = _toMap(contact);

    return db.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);

    return _toList(result);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_fullname] = contact.fullName;
    contactMap[_account] = contact.account;

    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> contactsMap) {
    final List<Contact> contacts = List<Contact>();

    for (Map<String, dynamic> row in contactsMap) {
      final Contact contact = Contact(row[_id], row[_fullname], row[_account]);
      contacts.add(contact);
    }

    return contacts;
  }
}