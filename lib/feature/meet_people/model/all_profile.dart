class ProfileResponse {
  final String id;
  final String? userId;
  final String? fullName;
  final String? age;
  final String? profileImage;
  final String isVerified;
  final String? country;
  final String? city;
  final UserStatus? user;
  final String? status;
  final String? flag;
  final bool? isFavorite; // New field added

  ProfileResponse({
    required this.id,
    this.userId,
    this.fullName,
    this.age,
    this.profileImage,
    required this.isVerified,
    this.country,
    this.city,
    this.user,
    this.status,
    this.flag,
    this.isFavorite,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      fullName: json['fullName'] as String?,
      age: json['age'] as String?,
      profileImage: json['profileImage'] as String?,
      isVerified: json['isVerified'] as String,
      country: json['country'] as String?,
      city: json['city'] as String?,
      user: json['user'] != null ? UserStatus.fromJson(json['user']) : null,
      status: json['status'] as String?,
      flag: json['flag'] as String?,
      isFavorite: json['isFavorite'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'age': age,
      'profileImage': profileImage,
      'isVerified': isVerified,
      'country': country,
      'city': city,
      'user': user?.toJson(),
      'status': status,
      'flag': flag,
      'isFavorite': isFavorite, 
    };
  }
}

class UserStatus {
  final String status;

  UserStatus({
    required this.status,
  });

  factory UserStatus.fromJson(Map<String, dynamic> json) {
    return UserStatus(
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}
