class Contact {
  final int id;
  final String name;
  final String accountNumber;

  Contact(this.id,
      this.name,
      this.accountNumber,);

  @override
  String toString() {
    return 'Contact{id: $id name: $name, accountNumber: $accountNumber}';
  }
}
