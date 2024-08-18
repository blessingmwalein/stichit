class TransactionStatus {
  static const String pending = 'Pending';
  static const String canceled = 'Canceled';
  static const String paid = 'Paid';

  static const List<String> values = [
    pending,
    canceled,
    paid,
  ];

  final String name;

  const TransactionStatus(this.name);

  //create transaction status from string
  static TransactionStatus fromString(String name) {
    return TransactionStatus(name);
  }
}
