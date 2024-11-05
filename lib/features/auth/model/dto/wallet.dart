class Wallet {
  final int id;
  final int userId;
  final double balance;
  final String createdAt;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.createdAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      userId: json['userId'],
      balance: json['balance'].toDouble(),
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'balance': balance,
      'createdAt': createdAt,
    };
  }
}
