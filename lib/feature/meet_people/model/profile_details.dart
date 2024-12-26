class SingleProfileDetails {
  final String? id;
  final String? userId;
  final String? fullName;
  final String? username;
  final String? profileImage;
  final List<String>? gallery;
  final String? isVerified;
  final String? about;
  final String? country;
  final String? flag;
  final String? city;
  final List<String>? interests;
  final String? locationLang;
  final String? locationLat;
  final String? relationship;
  final String? language;
  final String? gender;
  final String? age;
  final String? height;
  final String? work;
  final UserProfileStatus? user;

  SingleProfileDetails({
    this.id,
    this.userId,
    this.fullName,
    this.username,
    this.profileImage,
    this.gallery,
    this.isVerified,
    this.about,
    this.country,
    this.flag,
    this.city,
    this.interests,
    this.locationLang,
    this.locationLat,
    this.relationship,
    this.language,
    this.gender,
    this.age,
    this.height,
    this.work,
    this.user,
  });

  factory SingleProfileDetails.fromJson(Map<String, dynamic> json) {
    return SingleProfileDetails(
      id: json['id'],
      userId: json['userId'],
      fullName: json['fullName'],
      username: json['username'],
      profileImage: json['profileImage'],
      gallery: List<String>.from(json['gallery'] ?? []),
      isVerified: json['isVerified'],
      about: json['about'],
      country: json['country'],
      flag: json['flag'],
      city: json['city'],
      interests: List<String>.from(json['interests'] ?? []),
      locationLang: json['locationLang'],
      locationLat: json['locationLat'],
      relationship: json['relationship'],
      language: json['language'],
      gender: json['gender'],
      age: json['age'],
      height: json['height'],
      work: json['work'],
      user: json['user'] != null
          ? UserProfileStatus.fromJson(json['user'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'username': username,
      'profileImage': profileImage,
      'gallery': gallery,
      'isVerified': isVerified,
      'about': about,
      'country': country,
      'flag': flag,
      'city': city,
      'interests': interests,
      'locationLang': locationLang,
      'locationLat': locationLat,
      'relationship': relationship,
      'language': language,
      'gender': gender,
      'age': age,
      'height': height,
      'work': work,
      'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'ProfileResponse(id: $id, userId: $userId, fullName: $fullName, username: $username, profileImage: $profileImage, '
        'gallery: $gallery, isVerified: $isVerified, about: $about, country: $country, flag: $flag, '
        'city: $city, interests: $interests, locationLang: $locationLang, locationLat: $locationLat, '
        'relationship: $relationship, language: $language, gender: $gender, age: $age, height: $height, '
        'work: $work, user: $user)';
  }
}

class UserProfileStatus {
  final String status;

  UserProfileStatus({
    required this.status,
  });

  factory UserProfileStatus.fromJson(Map<String, dynamic> json) {
    return UserProfileStatus(
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }

  @override
  String toString() {
    return 'UserStatus(status: $status)';
  }
}
