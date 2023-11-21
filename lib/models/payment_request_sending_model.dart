

class PaymentRequestSendingModel {
  String? id;
  String user;
  String agent;
  String property;
  String paymentAmount;

  PaymentRequestSendingModel({
    this.id,
    required this.user,
    required this.agent,
    required this.property,
    required this.paymentAmount,
  });

  factory PaymentRequestSendingModel.fromJson(Map<String, dynamic> json) {
    return PaymentRequestSendingModel(
      id: json['_id'],
      user: json['user'],
      agent: json['agent'],
      property: json['property'],
      paymentAmount: json['paymentAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'agent': agent,
      'user': user,
      'property': property,
      'paymentAmount': paymentAmount,
    };

    return data;
  }
}
