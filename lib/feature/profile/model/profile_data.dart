class UserData {
  final String? fullName;
  final String? username;
  final String? profileImage;
  final List<String>? gallery;
  final String? isVerified;
  final String? about;
  final String? country;
  final String? city;
  final List<String>? interests;
  final String? locationLang;
  final String? locationLat;
  final String? relationship;
  final String? language;
  final String? gender;
  final int? age;
  final String? height;
  final String? work;

  UserData({
    this.fullName,
    this.username,
    this.profileImage,
    this.gallery,
    this.isVerified,
    this.about,
    this.country,
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
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      fullName: json['fullName'],
      username: json['username'],
      profileImage: json['profileImage'],
      gallery: List<String>.from(json['gallery'] ?? []),
      isVerified: json['isVerified'],
      about: json['about'],
      country: json['country'],
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'username': username,
      'profileImage': profileImage,
      'gallery': gallery,
      'isVerified': isVerified,
      'about': about,
      'country': country,
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
    };
  }

  @override
  String toString() {
    return 'UserData(fullName: $fullName, username: $username, profileImage: $profileImage, '
        'gallery: $gallery, isVerified: $isVerified, about: $about, country: $country, '
        'city: $city, interests: $interests, locationLang: $locationLang, locationLat: $locationLat, '
        'relationship: $relationship, language: $language, gender: $gender, age: $age, height: $height, work: $work)';
  }
}
