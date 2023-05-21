import 'package:flutter_test/flutter_test.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';

void main() {
  const tContactModel = ContactModel(
    modelId: 1,
    modelPhoneNumber: 'Test Phone',
    modelFirstName: 'Test First',
    modelLastName: 'Test Last',
  );


  test('check if it\'s a Contact', () {
    expect(tContactModel, isA<Contact>());
  });

}
