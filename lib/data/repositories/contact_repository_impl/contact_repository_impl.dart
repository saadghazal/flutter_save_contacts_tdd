import 'package:dartz/dartz.dart';
import 'package:save_contacts_tdd/core/error/exceptions.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/domain/repositories/contact_repository/contact_repository.dart';

import '../../data_sources/contacts_data_source/contact_local_data_source.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactLocalDataSource contactLocalDataSource;

  const ContactRepositoryImpl({
    required this.contactLocalDataSource,
  });

  @override
  Future<Either<Failure, List<Contact>>> getContacts() async {
    try {
      final result = await contactLocalDataSource.getAllContacts();
      final List<Contact> contacts = result;
      return Right(contacts);
    } on CacheException {
      return Left(CacheFailure());
    } on UnexpectedException {
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, List<Contact>>> addContact(Contact contact) async {
    final ContactModel contactModel = ContactModel(
      modelId: contact.id,
      modelPhoneNumber: contact.phoneNumber,
      modelFirstName: contact.firstName,
      modelLastName: contact.lastName,
    );
    try{
      final result = await contactLocalDataSource.addContact(contactModel);
      final List<Contact> contacts = result;
      return Right(contacts);
    }on CacheException{
      return Left(CacheFailure());
    }on UnexpectedException{
      return Left(UnexpectedFailure());
    }

  }
}
