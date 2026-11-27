class CallListModel {
  final String id;
  final String name;
  final String clientId;

  CallListModel({required this.id, required this.name, required this.clientId});

  factory CallListModel.fromJson(Map<String, dynamic> json) {
    return CallListModel(
      id: json['_id']?.toString() ?? '68626fb697757cb741f449b9',
      name: json['name']?.toString() ?? 'Test List',
      clientId: json['clientId']?.toString() ?? '68626f9497757cb741f449b0',
    );
  }
}

class ListDetailsModel {
  final int pending;
  final int called;
  final int rescheduled;
  final int totalCalls;

  ListDetailsModel({
    required this.pending,
    required this.called,
    required this.rescheduled,
    required this.totalCalls,
  });

  factory ListDetailsModel.fromJson(Map<String, dynamic> json) {
    final callsList = json['calls'] as List<dynamic>? ?? [];
    return ListDetailsModel(
      pending: json['pending'] ?? 0,
      called: json['called'] ?? 0,
      rescheduled: json['rescheduled'] ?? 0,
      totalCalls: callsList.length,
    );
  }
}
