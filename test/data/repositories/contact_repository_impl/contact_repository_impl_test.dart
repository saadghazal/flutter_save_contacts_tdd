import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'package:mockito/mockito.dart';
import 'package:save_contacts_tdd/core/error/exceptions.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';
import 'package:save_contacts_tdd/data/data_sources/contacts_data_source/contact_local_data_source.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';
import 'package:save_contacts_tdd/data/repositories/contact_repository_impl/contact_repository_impl.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';

import 'contact_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ContactLocalDataSource>()])
void main() {
  late MockContactLocalDataSource mockLocal;
  late ContactRepositoryImpl contactRepositoryImpl;
  setUp(() {
    mockLocal = MockContactLocalDataSource();
    contactRepositoryImpl =
        ContactRepositoryImpl(contactLocalDataSource: mockLocal);
  });

  group(
    'Get All Contacts',
    () {
      const tContactModel = ContactModel(
        modelId: 1,
        modelPhoneNumber: 'Test Phone',
        modelFirstName: 'Test First',
        modelLastName: 'Test Last',
      );

      final tContactModelList = [
        tContactModel,
      ];

      final List<Contact> contacts = tContactModelList;

      test(
        'should return List<Contact> when the call successfully performed',
        () async {
          when(mockLocal.getAllContacts())
              .thenAnswer((_) async => tContactModelList);

          final result = await contactRepositoryImpl.getContacts();

          expect(result, Right(contacts));
          verify(mockLocal.getAllContacts());
        },
      );

      test(
        'should return CacheFailure when there is no contacts saved before',
        () async {
          when(mockLocal.getAllContacts()).thenThrow(CacheException());

          final result = await contactRepositoryImpl.getContacts();

          expect(result, Left(CacheFailure()));
          verify(mockLocal.getAllContacts());
        },
      );

      test(
        'should return UnexpectedFailure when there is unexpected bug',
        () async {
          when(mockLocal.getAllContacts()).thenThrow(UnexpectedException());

          final result = await contactRepositoryImpl.getContacts();

          expect(result, Left(UnexpectedFailure()));
          verify(mockLocal.getAllContacts());
        },
      );
    },
  );

  group(
    'Add Contact ',
    () {
      const tContactModel = ContactModel(
        modelId: 1,
        modelPhoneNumber: 'Test Phone',
        modelFirstName: 'Test First',
        modelLastName: 'Test Last',
      );
      const tContact = Contact(
        id: 1,
        phoneNumber: 'Test Phone',
        firstName: 'Test First',
        lastName: 'Test Last',
      );

      final tContactModelList = [
        tContactModel,
      ];

      final List<Contact> contacts = tContactModelList;

      test(
        'should return List<Contact> when the call successfully performed',
        () async {
          when(mockLocal.addContact(any))
              .thenAnswer((_) async => tContactModelList);

          final result = await contactRepositoryImpl.addContact(tContact);

          expect(result, Right(contacts));
          verify(mockLocal.addContact(tContactModel));
        },
      );

      test(
        'should return CacheFailure when there is a bug',
        () async {
          when(mockLocal.addContact(any)).thenThrow(CacheException());

          final result = await contactRepositoryImpl.addContact(tContact);

          expect(result, Left(CacheFailure()));
          verify(mockLocal.addContact(tContactModel));
        },
      );

      test(
        'should return UnexpectedFailure when there is unexpected bug',
        () async {
          when(mockLocal.addContact(any)).thenThrow(UnexpectedException());

          final result = await contactRepositoryImpl.addContact(tContact);

          expect(result, Left(UnexpectedFailure()));
          verify(mockLocal.addContact(tContactModel));
        },
      );
    },
  );
}
