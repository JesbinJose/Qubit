class Message {
  final int id;
  final DateTime time;
  final String content;

  Message({
    required this.id,
    required this.time,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json['sender'],
      time: DateTime.parse(json["timestamp"]),
      content: json['message']
    );
  }
}
