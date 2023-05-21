import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:save_contacts_tdd/core/error/exceptions.dart';

import 'package:save_contacts_tdd/data/data_sources/contacts_data_source/contact_local_data_source.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';

import 'contact_local_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HiveInterface>(),
  MockSpec<Box>(),
])
void main() {
  late MockBox mockBox;
  late ContactLocalDataSourceImpl impl;
  setUp(() {
    mockBox = MockBox();
    impl = ContactLocalDataSourceImpl(contactsBox: mockBox);
  });

  group(
    'Get All Contacts',
    () {
      const tContactModel = ContactModel(
        modelId: 1,
        modelPhoneNumber: 'Test Phone',
        modelFirstName: 'Test Name',
        modelLastName: 'Test Last',
      );
      const contactsList = [tContactModel];

      group(
        'Contains A Key',
        () {
          setUp(
            () {
              when(mockBox.containsKey(contactsKey)).thenReturn(true);
            },
          );
          test(
            'should return List<ContactModel> if there is a contacts in the cache',
            () async {
              when(mockBox.get(any)).thenAnswer((_) async => contactsList);

              final result = await impl.getAllContacts();

              expect(result, contactsList);
              verify(mockBox.get(contactsKey));
            },
          );
        },
      );

      group(
        'Contains No Key',
        () {
          setUp(
            () {
              when(mockBox.containsKey(contactsKey)).thenReturn(false);
            },
          );
          test(
            'should throw a CacheException if there is no contacts in the cache',
            () async {
              final result = impl.getAllContacts;

              expect(() => result(), throwsA(TypeMatcher<CacheException>()));
            },
          );
        },
      );
    },
  );

  group(
    'Add a contact',
    () {
      var tContactModel = ContactModel(
        modelId: 1,
        modelPhoneNumber: 'Test Phone',
        modelFirstName: 'Test Name',
        modelLastName: 'Test Last',
      );
      var contactsList = [tContactModel];

      test('check if there is a key', ()async {


        await impl.addContact(tContactModel);

        verify(mockBox.containsKey(contactsKey));


      },);

      group(
        'Does not contain a key',
        () {
          setUp(
            () {
              when(mockBox.containsKey(contactsKey)).thenReturn(false);
            },
          );
          test(
            'should return List<ContactModel> when add a new contact to the list of contacts',
            () async {
              when(mockBox.put(any, any)).thenAnswer((_) async => isA<void>);

              final result = await impl.addContact(tContactModel);

              expect(result, contactsList);
              verify(mockBox.put(contactsKey,contactsList));
            },
          );
        },
      );

      group(
        'Does not contain a key',
            () {
          setUp(
                () {
              when(mockBox.containsKey(contactsKey)).thenReturn(true);
              when(mockBox.get(contactsKey)).thenAnswer((_) async=> contactsList);
            },
          );
          test(
            'should return List<ContactModel> when add a new contact to the list of contacts',
                () async {
              when(mockBox.put(any, any)).thenAnswer((_) async => isA<void>);


            final result= await impl.addContact(tContactModel);
               var newList=contactsList;
               newList.add(tContactModel);

              expect(result, newList);
              verify(mockBox.put(contactsKey,contactsList));
              verify(mockBox.get(contactsKey));
            },
          );
        },
      );
    },
  );
}
