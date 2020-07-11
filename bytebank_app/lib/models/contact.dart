class Contact {
  final int id;
  final String fullName;
  final int account;

  Contact(this.id, this.fullName, this.account);

  @override
  String toString() => 'fullName: $fullName - account: $account';

  Contact.fromJson(Map<String, dynamic> jsonMap) :
        this.id = jsonMap['id'],
        this.fullName = jsonMap['name'],
        this.account = jsonMap['accountNumber'];

  Map<String, dynamic> toJson(Contact contact) =>
      {
        'name': contact.fullName,
        'accountNumber': contact.account
      };
}