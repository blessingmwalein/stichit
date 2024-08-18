class OrderStatus {
  static const String created = 'Created';
  static const String reaceived = 'Received';
  static const String processed = 'Processed';
  static const String inProgress = 'In Progress';
  static const String delivered = 'Delivered';

  static const List<String> values = [
    created,
    reaceived,
    processed,
    inProgress,
    delivered
  ];

  final String name;

  const OrderStatus(this.name);

  //create order status from string
  static OrderStatus fromString(String name) {
    return OrderStatus(name);
  }
}
