import 'package:hive/hive.dart';
import 'package:save_contacts_tdd/core/error/exceptions.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';

const boxName = 'contacts-box';
const contactsKey = 'Contacts-Key';

abstract class ContactLocalDataSource {
  Future<List<ContactModel>> addContact(ContactModel contactModel);

  Future<List<ContactModel>> getAllContacts();
}

class ContactLocalDataSourceImpl implements ContactLocalDataSource {
  final Box contactsBox;
  const ContactLocalDataSourceImpl({
    required this.contactsBox,
  });

  @override
  Future<List<ContactModel>> getAllContacts() async {
   final contacts=  contactsBox.values.toList().cast<ContactModel>();

    if (contacts.isNotEmpty) {
      return contacts;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<ContactModel>> addContact(ContactModel contactModel) async {
    
      await contactsBox.put(contactModel.modelId, contactModel);
      final newContacts=await getAllContacts();
      return newContacts;

  }
}
