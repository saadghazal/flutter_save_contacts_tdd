import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';

import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/add_contact_usecase.dart';

import 'get_contacts_usecase.mocks.dart';

void main() {
  late MockContactRepository mockContactRepository;
  late AddContactUseCase useCase;
  setUp(() {
    mockContactRepository = MockContactRepository();
    useCase = AddContactUseCase(contactRepository: mockContactRepository);
  });

  const tContact = Contact(
    id: 1,
    phoneNumber: 'Test Phone',
    firstName: 'Test First',
    lastName: 'Test Last',
  );
  final contactsList = [
    tContact,
  ];
  test(
    'should return a List<Contact> when we call usecase successfully',
    () async {
      when(mockContactRepository.addContact(any))
          .thenAnswer((_) async => Right(contactsList));

      final result = await useCase(tContact);

      expect(result, Right(contactsList));
    },
  );
}
