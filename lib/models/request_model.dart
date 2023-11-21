import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/models/user_model.dart';

class RequestModel {
  String? id;
  String agent;
  UserModel? user;
  PropertyModel? property;
  String? requestName;

  RequestModel({
    this.id,
    required this.agent,
    this.user,
    this.property,
    this.requestName,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['_id'],
      agent: json['agent'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      property: json['property'] != null ? PropertyModel.fromJson(json['property']) : null,
      requestName: json['requestName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'agent': agent,
      'requestName': requestName,
    };

    if (id != null) {
      data['_id'] = id;
    }

    if (user != null) {
      data['user'] = user!.toJson();
    }

    if (property != null) {
      data['property'] = property!.toJson();
    }

    return data;
  }
}