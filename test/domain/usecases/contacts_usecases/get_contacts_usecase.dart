import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/domain/repositories/contact_repository/contact_repository.dart';
import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/get_contacts_usecase.dart';

import 'get_contacts_usecase.mocks.dart';

@GenerateNiceMocks([MockSpec<ContactRepository>()])
void main() {
  late MockContactRepository mockContactRepository;
  late GetContactsUseCase useCase;
  setUp(() {
    mockContactRepository = MockContactRepository();
    useCase = GetContactsUseCase(contactRepository: mockContactRepository);
  });

  final contactsList = [
    const Contact(
      id: 1,
      phoneNumber: 'Test Phone',
      firstName: 'Test First',
      lastName: 'Test Last',
    ),
  ];
  test(
    'should return a List<Contact> when we call usecase successfully',
    () async {
      when(mockContactRepository.getContacts())
          .thenAnswer((_) async => Right(contactsList));

      final result= await useCase();

      expect(result, Right(contactsList));
    },
  );
}
