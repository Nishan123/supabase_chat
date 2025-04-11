import 'dart:convert';

class MessageModel {
  String messageId;
  String message;
  String senderId;
  String reciverId;
  String? sendAt;
  bool isImage;
  MessageModel({
    required this.messageId,
    required this.message,
    required this.senderId,
    required this.reciverId,
    this.sendAt,
    required this.isImage,
  });

  MessageModel copyWith({
    String? messageId,
    String? message,
    String? senderId,
    String? reciverId,
    String? sendAt,
    bool? isImage,
  }) {
    return MessageModel(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      reciverId: reciverId ?? this.reciverId,
      sendAt: sendAt ?? this.sendAt,
      isImage: isImage ?? this.isImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'message': message,
      'senderId': senderId,
      'reciverId': reciverId,
      'sendAt': sendAt,
      'isImage': isImage,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] as String,
      message: map['message'] as String,
      senderId: map['senderId'] as String,
      reciverId: map['reciverId'] as String,
      sendAt: map['sendAt'] != null ? map['sendAt'] as String : null,
      isImage: map['isImage'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(messageId: $messageId, message: $message, senderId: $senderId, reciverId: $reciverId, sendAt: $sendAt, isImage: $isImage)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.messageId == messageId &&
      other.message == message &&
      other.senderId == senderId &&
      other.reciverId == reciverId &&
      other.sendAt == sendAt &&
      other.isImage == isImage;
  }

  @override
  int get hashCode {
    return messageId.hashCode ^
      message.hashCode ^
      senderId.hashCode ^
      reciverId.hashCode ^
      sendAt.hashCode ^
      isImage.hashCode;
  }
}
