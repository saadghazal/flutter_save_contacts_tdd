part of 'contacts_bloc.dart';

abstract class ContactsEvent extends Equatable {
  const ContactsEvent();
}


class GetAllContacts extends ContactsEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddContact extends ContactsEvent {
  final Contact contact;

  const AddContact({
    required this.contact,
  });

  @override
  List<Object> get props => [contact];
}