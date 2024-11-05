class Vehicle {
  String licensePlate;
  String vehicleType;
  bool isVerified;
  String registration;
  String vehicleImageUrl;
  String registrationImageUrl;

  Vehicle({
    required this.licensePlate,
    required this.vehicleType,
    required this.isVerified,
    required this.registration,
    required this.vehicleImageUrl,
    required this.registrationImageUrl,
  });
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      licensePlate: json['LicensePlate'],
      vehicleType: json['VehicleType'],
      isVerified: json['IsVerified'],
      registration: json['Registration'],
      vehicleImageUrl: json['VehicleImageUrl'],
      registrationImageUrl: json['RegistrationImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LicensePlate': licensePlate,
      'VehicleType': vehicleType,
      'IsVerified': isVerified,
      'Registration': registration,
      'VehicleImageUrl': vehicleImageUrl,
      'RegistrationImageUrl': registrationImageUrl,
    };
  }
}
