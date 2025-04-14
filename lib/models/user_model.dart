import 'dart:convert';

class UserModel {
  String uid;
  String fullName;
  String profileUrl;
  String gmail;
  String joinedAt;
  UserModel({
    required this.uid,
    required this.fullName,
    required this.profileUrl,
    required this.gmail,
    required this.joinedAt,
  });

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? profileUrl,
    String? gmail,
    String? joinedAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      profileUrl: profileUrl ?? this.profileUrl,
      gmail: gmail ?? this.gmail,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'profileUrl': profileUrl,
      'gmail': gmail,
      'joinedAt': joinedAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      fullName: map['fullName'] as String,
      profileUrl: map['profileUrl'] as String,
      gmail: map['gmail'] as String,
      joinedAt: map['joinedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, profileUrl: $profileUrl, gmail: $gmail, joinedAt: $joinedAt)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.fullName == fullName &&
      other.profileUrl == profileUrl &&
      other.gmail == gmail &&
      other.joinedAt == joinedAt;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      fullName.hashCode ^
      profileUrl.hashCode ^
      gmail.hashCode ^
      joinedAt.hashCode;
  }
}
