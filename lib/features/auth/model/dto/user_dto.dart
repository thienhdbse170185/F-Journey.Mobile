class UserDto {
  int id;
  String email;
  String username;
  String fullname;
  String password;
  String address;
  bool gender;

  UserDto({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    required this.password,
    required this.address,
    required this.gender,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      fullname: json['fullname'],
      password: json['password'],
      address: json['address'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'password': password,
      'address': address,
      'gender': gender,
    };
  }

  @override
  String toString() {
    return 'UserDto{id: $id, email: $email, username: $username, fullname: $fullname, password: $password, address: $address, gender: $gender}';
  }
}
