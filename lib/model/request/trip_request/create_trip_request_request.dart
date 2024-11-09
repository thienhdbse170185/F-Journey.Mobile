class CreateTripRequestRequest {
  int userId;
  int fromZoneId;
  int toZoneId;
  String tripDate;
  String startTime;
  int slot;
  String status;

  CreateTripRequestRequest({
    required this.userId,
    required this.fromZoneId,
    required this.toZoneId,
    required this.tripDate,
    required this.startTime,
    required this.slot,
    required this.status,
  });

  factory CreateTripRequestRequest.fromJson(Map<String, dynamic> json) {
    return CreateTripRequestRequest(
      userId: json['userId'],
      fromZoneId: json['fromZoneId'],
      toZoneId: json['toZoneId'],
      tripDate: json['tripDate'],
      startTime: json['startTime'],
      slot: json['slot'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fromZoneId': fromZoneId,
      'toZoneId': toZoneId,
      'tripDate': tripDate,
      'startTime': startTime,
      'slot': slot,
      'status': status,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}
