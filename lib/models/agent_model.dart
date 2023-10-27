class AgentModel {
  String id;
  String? name;
  String? email;
  String? phone;
  bool? isBanned;
  String? image;
  String? token;

  AgentModel({
    required this.id,
    this.name,
    this.email,
    this.phone,
    this.isBanned,
    this.image,
    this.token,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) => AgentModel(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        token: json['token'],
        isBanned: json['isBanned'] ?? false,
      );

  static Map<String, dynamic> toJson(AgentModel agent) => {
        '_id': agent.id,
        'name': agent.name,
        'email': agent.email,
        'phone': agent.phone,
        'image': agent.image,
        'token': agent.token,
        'isBanned': agent.isBanned,
      };
}