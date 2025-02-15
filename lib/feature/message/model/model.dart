// class ChatData {
//   final UserChatList user;
//   final String? lastMessage;
//   final DateTime? lastMessageDate;

//   ChatData({
//     required this.user,
//     this.lastMessage,
//     this.lastMessageDate,
//   });

//   factory ChatData.fromJson(Map<String, dynamic> json) {
//     return ChatData(
//       user: UserChatList.fromJson(json['user'] as Map<String, dynamic>),
//       lastMessage: json['lastMessage'] as String?,
//       lastMessageDate: json['lastMessageDate'] != null
//           ? DateTime.parse(json['lastMessageDate'] as String)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'user': user.toJson(),
//       'lastMessage': lastMessage,
//       'lastMessageDate': lastMessageDate?.toIso8601String(),
//     };
//   }
// }

// class UserChatList {
//   final String userId;
//   final String fullName;
//   final String? profileImage;

//   UserChatList({
//     required this.userId,
//     required this.fullName,
//     this.profileImage,
//   });

//   factory UserChatList.fromJson(Map<String, dynamic> json) {
//     return UserChatList(
//       userId: json['userId'] as String,
//       fullName: json['fullName'] as String,
//       profileImage: json['profileImage'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'fullName': fullName,
//       'profileImage': profileImage,
//     };
//   }
// }

class ChatData {
  final UserChatList user;
  final String? lastMessage;
  final DateTime? lastMessageDate;

  ChatData({
    required this.user,
    this.lastMessage,
    this.lastMessageDate,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) {
    return ChatData(
      user: UserChatList.fromJson(json['user'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] as String?,
      lastMessageDate: json['lastMessageDate'] != null
          ? DateTime.tryParse(json['lastMessageDate'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'lastMessage': lastMessage,
      'lastMessageDate': lastMessageDate?.toIso8601String(),
    };
  }
}

class UserChatList {
  final String userId;
  final String? fullName; // Changed to nullable
  final String? profileImage;

  UserChatList({
    required this.userId,
    this.fullName, // Nullable now
    this.profileImage,
  });

  factory UserChatList.fromJson(Map<String, dynamic> json) {
    return UserChatList(
      userId: json['userId'] as String,
      fullName: json['fullName'] as String?, // Allow null values
      profileImage: json['profileImage'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'profileImage': profileImage,
    };
  }
}
