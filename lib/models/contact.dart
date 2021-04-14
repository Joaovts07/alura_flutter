class Contact {
  final String name;
  final String accountNumber;

  Contact(
    this.name,
    this.accountNumber,
  );

  @override
  String toString() {
    return 'Contact{name: $name, accountNumber: $accountNumber}';
  }
}
