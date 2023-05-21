import 'package:dartz/dartz.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';

import '../../../core/error/failure.dart';

abstract class ContactRepository{

  Future<Either<Failure,List<Contact>>> getContacts();

  Future<Either<Failure,List<Contact>>> addContact(Contact contact);

}