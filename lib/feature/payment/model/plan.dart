class Plan {
  final String id;
  final String planName;
  final String duration;
  final double price;
  final String productId;
  final String? description;
  final String priceId;
  final String paypalProductId;
  final String paypalPlanId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Plan({
    required this.id,
    required this.planName,
    required this.duration,
    required this.price,
    required this.productId,
    this.description,
    required this.priceId,
    required this.paypalProductId,
    required this.paypalPlanId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return Plan(
      id: json['id'] as String,
      planName: json['planName'] as String,
      duration: json['duration'] as String,
      price: (json['price'] as num).toDouble(),
      productId: json['productId'] as String,
      description: json['description'] as String?,
      priceId: json['priceId'] as String,
      paypalProductId: json['paypalProductId'] as String,
      paypalPlanId: json['paypalPlanId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class PlansResponse {
  final bool success;
  final int statusCode;
  final String message;
  final List<Plan> data;

  PlansResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PlansResponse.fromJson(Map<String, dynamic> json) {
    return PlansResponse(
      success: json['success'] as bool,
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((item) => Plan.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
