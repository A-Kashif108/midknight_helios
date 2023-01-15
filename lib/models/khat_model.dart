class KhatModel {
  final String content;
  final String senderId;
  final String receiverId;
  final String createdAt;

  KhatModel(
      {required this.createdAt,
      required this.content,
      required this.senderId,
      required this.receiverId});

  KhatModel.fromJson(Map<String, dynamic> map)
      : content = map["content"],
        createdAt = map["createdAt"],
        senderId = map["senderId"],
        receiverId = map["receiverId"];

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt,
      'senderId': senderId,
      'receiverId': receiverId,
    };
  }
}
