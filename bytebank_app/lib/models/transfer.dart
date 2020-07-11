import 'contact.dart';

class Transfer {
  final String id;
  final Contact contact;
  final double value;

  Transfer(this.id, this.contact, this.value);

  @override
  String toString() => 'contact: $contact, value: $value';

  Transfer.fromJson(Map<String, dynamic> jsonMap) :
        this.id = jsonMap['id'],
        this.value = jsonMap['value'],
        this.contact = Contact.fromJson(jsonMap['contact']);

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'value': value,
        'contact': contact.toJson(contact),
      };
}