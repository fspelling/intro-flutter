import 'package:bytebankWebApi/models/contact.dart';

class Transfer {
  final Contact contact;
  final double value;

  Transfer(this.contact, this.value);

  @override
  String toString() => 'contact: $contact, value: $value';

  Transfer.fromJson(Map<String, dynamic> jsonMap) :
      this.contact = Contact.fromJson(jsonMap['contact']),
      this.value = jsonMap['value'];

  Map<String, dynamic> toJson(Transfer transaction) =>
      {
        'contact': transaction.contact.toJson(transaction.contact),
        'value': transaction.value
      };
}