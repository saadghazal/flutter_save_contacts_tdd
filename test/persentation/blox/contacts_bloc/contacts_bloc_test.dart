import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/add_contact_usecase.dart';
import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/get_contacts_usecase.dart';
import 'package:save_contacts_tdd/persentation/blox/contacts_bloc/contacts_bloc.dart';

import 'contacts_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddContactUseCase>(),
  MockSpec<GetContactsUseCase>(),
])
void main() {
  late MockAddContactUseCase mockAdd;
  late MockGetContactsUseCase mockGet;
  late ContactsBloc contactsBloc;
  setUp(
    () {
      mockAdd = MockAddContactUseCase();
      mockGet = MockGetContactsUseCase();
      contactsBloc = ContactsBloc(
        getContactsUseCase: mockGet,
        addContactUseCase: mockAdd,
      );
    },
  );

  group(
    'Get Contacts Use Case',
    () {
      final tContact = Contact(
        id: 1,
        phoneNumber: 'Test Phone',
        firstName: 'Test First',
        lastName: 'Test Last',
      );
      final tContactsList = [tContact];

      blocTest(
        'should emit LoadedStatus when the call successfully performed',
        build: () {
          when(mockGet()).thenAnswer((_) async => Right(tContactsList));
          return contactsBloc;
        },
        act: (bloc) {
          bloc.add(GetAllContacts());
        },
        expect: () => <ContactsState>[
          ContactsState(
            contactsStatus: ContactsStatus.loading,
            contacts: [],
            errorMessage: '',
          ),
          ContactsState(
            contactsStatus: ContactsStatus.loaded,
            contacts: tContactsList,
            errorMessage: '',
          ),
        ],
      );

      blocTest(
        'should emit emptyStatus when the call successfully performed and there is no cache',
        build: () {
          when(mockGet()).thenAnswer((_) async => Left(CacheFailure()));
          return contactsBloc;
        },
        act: (bloc) {
          bloc.add(GetAllContacts());
        },
        expect: () => const <ContactsState> [
          ContactsState(
            contactsStatus: ContactsStatus.loading,
            contacts: [],
            errorMessage: '',
          ),
          ContactsState(
            contactsStatus: ContactsStatus.empty,
            contacts: [],
            errorMessage: EMPTY_CACHE_MESSAGE,
          ),
        ],
      );

      blocTest(
        'should emit error when the call unsuccessfully performed based on unexpected bug',
        build: () {
          when(mockGet()).thenAnswer((_) async => Left(UnexpectedFailure()));
          return contactsBloc;
        },
        act: (bloc) {
          bloc.add(GetAllContacts());
        },
        expect: () => const <ContactsState> [
          ContactsState(
            contactsStatus: ContactsStatus.loading,
            contacts: [],
            errorMessage: '',
          ),
          ContactsState(
            contactsStatus: ContactsStatus.error,
            contacts: [],
            errorMessage: UNEXPECTED_MESSAGE,
          ),
        ],
      );
    },
  );

  group(
    'Add Contact Use Case',
        () {
      final tContact = Contact(
        id: 1,
        phoneNumber: 'Test Phone',
        firstName: 'Test First',
        lastName: 'Test Last',
      );
      final tContactsList = [tContact];

      blocTest(
        'should emit LoadedStatus when the call successfully performed',
        build: () {
          when(mockAdd(any)).thenAnswer((_) async => Right(tContactsList));
          return contactsBloc;
        },
        act: (bloc) {
          bloc.add(AddContact(contact: tContact));
        },
        expect: () => <ContactsState>[
          ContactsState(
            contactsStatus: ContactsStatus.loading,
            contacts: [],
            errorMessage: '',
          ),
          ContactsState(
            contactsStatus: ContactsStatus.loaded,
            contacts: tContactsList,
            errorMessage: '',
          ),
        ],
      );

      blocTest(
        'should emit errorStatus when the call unsuccessfully performed based on Unexpected Fail',
        build: () {
          when(mockGet()).thenAnswer((_) async => Left(UnexpectedFailure()));
          return contactsBloc;
        },
        act: (bloc) {
          bloc.add(GetAllContacts());
        },
        expect: () => const <ContactsState> [
          ContactsState(
            contactsStatus: ContactsStatus.loading,
            contacts: [],
            errorMessage: '',
          ),
          ContactsState(
            contactsStatus: ContactsStatus.error,
            contacts: [],
            errorMessage: UNEXPECTED_MESSAGE,
          ),
        ],
      );

    },
  );
}
