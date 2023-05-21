part of 'contacts_bloc.dart';

enum ContactsStatus {
  initial,
  empty,
  loading,
  loaded,
  error,
}


class ContactsState extends Equatable {
  final ContactsStatus contactsStatus;
  final List<Contact> contacts;
  final String errorMessage;



  const ContactsState({
    required this.contactsStatus,
    required this.contacts,
    required this.errorMessage,
  });

  factory ContactsState.initial(){
    return ContactsState(contactsStatus: ContactsStatus.initial, contacts: [], errorMessage: '');
  }

  @override
  List<Object> get props => [contactsStatus, contacts, errorMessage];

  @override
  String toString() {
    return 'ContactsState{contactsStatus: $contactsStatus, contacts: $contacts, errorMessage: $errorMessage}';
  }

  ContactsState copyWith({
    ContactsStatus? contactsStatus,
    List<Contact>? contacts,
    String? errorMessage,
  }) {
    return ContactsState(
      contactsStatus: contactsStatus ?? this.contactsStatus,
      contacts: contacts ?? this.contacts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

