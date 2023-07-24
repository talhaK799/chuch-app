class Inventory {
  final int id;
  final int deptId;
  final String name;
  final String description;
  final int quantity;
  final DateTime createdAt;
  final String borrowedFrom;

  Inventory({
    required this.id,
    required this.deptId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.createdAt,
    required this.borrowedFrom,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json['id'],
      deptId: json['dept_id'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      borrowedFrom: json['borrowed_from'] ?? "",
    );
  }
}
