class Driver {
  String licenseNumber;
  bool verified;
  String licenseImageUrl;

  Driver({
    required this.licenseNumber,
    required this.verified,
    required this.licenseImageUrl,
  });
  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      licenseNumber: json['licenseNumber'],
      verified: json['verified'],
      licenseImageUrl: json['licenseImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'licenseNumber': licenseNumber,
      'verified': verified,
      'licenseImageUrl': licenseImageUrl,
    };
  }
}
