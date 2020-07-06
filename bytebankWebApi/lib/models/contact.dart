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
      this.account = jsonMap['account_name'];

  Map<String, dynamic> toJson(Contact contact) =>
      {
        'id': contact.id,
        'name': contact.fullName,
        'account_name': contact.account
      };
}