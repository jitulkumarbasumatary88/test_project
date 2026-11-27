import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/model/list_model.dart';

void main() {
  test('CallListModel JSON parsing test', () {
    final model = CallListModel.fromJson({
      '_id': '68626fb697757cb741f449b9',
      'name': 'Test Calling List',
    });
    expect(model.id, '68626fb697757cb741f449b9');
    expect(model.name, 'Test Calling List');
  });

  test('ListDetailsModel JSON parsing test', () {
    final model = ListDetailsModel.fromJson({
      'pending': 27,
      'called': 23,
      'rescheduled': 11,
    });
    expect(model.pending, 27);
    expect(model.called, 23);
    expect(model.rescheduled, 11);
  });
}
