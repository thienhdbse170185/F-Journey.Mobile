class LoginDto {
  final String email;
  final String password;

  LoginDto(this.email, this.password);

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(json['email'] as String, json['password'] as String);
  }

  @override
  String toString() {
    return 'LoginDto{email: $email, password: $password}';
  }
}
