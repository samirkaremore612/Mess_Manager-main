class User {
  final String name;
  final int phone;

  User({
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'Name': name,
    'Phone': phone,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    name: json['Name'],
    phone: json['Phone'],
  );
}