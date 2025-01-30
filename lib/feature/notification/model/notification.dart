class NotificationsResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<NotificationData> data;

  NotificationsResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => NotificationData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class NotificationData {
  final String id;
  final String receiverId;
  final String title;
  final String body;
  final bool read;
  final DateTime createdAt;
  final DateTime updatedAt;

  NotificationData({
    required this.id,
    required this.receiverId,
    required this.title,
    required this.body,
    required this.read,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      id: json['id'] as String,
      receiverId: json['receiverId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      read: json['read'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'receiverId': receiverId,
      'title': title,
      'body': body,
      'read': read,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
