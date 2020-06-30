class Contact {
  final int id;
  final String fullName;
  final int account;

  Contact(this.id, this.fullName, this.account);

  @override
  String toString() => 'fullName: $fullName - account: $account';
}