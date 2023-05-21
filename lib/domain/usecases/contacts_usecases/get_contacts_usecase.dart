import 'package:dartz/dartz.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/domain/repositories/contact_repository/contact_repository.dart';

class GetContactsUseCase{
final ContactRepository contactRepository;

const GetContactsUseCase({
    required this.contactRepository,
  });

Future<Either<Failure,List<Contact>>> call()async{
 return await contactRepository.getContacts();
}
}