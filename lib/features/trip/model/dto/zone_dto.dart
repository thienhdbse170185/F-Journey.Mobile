class ZoneDto {
  int id;
  String zoneName;
  String description;

  ZoneDto({
    required this.id,
    required this.zoneName,
    required this.description,
  });

  factory ZoneDto.fromJson(Map<String, dynamic> json) {
    return ZoneDto(
      id: json['id'],
      zoneName: json['zoneName'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'zoneName': zoneName,
      'description': description,
    };
  }
}
