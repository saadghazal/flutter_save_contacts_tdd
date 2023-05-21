import 'package:dartz/dartz.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/domain/repositories/contact_repository/contact_repository.dart';

class AddContactUseCase{
  final ContactRepository contactRepository;

  const AddContactUseCase({
    required this.contactRepository,
  });


  Future<Either<Failure,List<Contact>>> call(Contact contact)async{

    return await contactRepository.addContact(contact);
  }


}