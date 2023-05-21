import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:save_contacts_tdd/core/error/failure.dart';

import '../../../domain/entities/contact_entity/contact.dart';
import '../../../domain/usecases/contacts_usecases/add_contact_usecase.dart';
import '../../../domain/usecases/contacts_usecases/get_contacts_usecase.dart';

part 'contacts_event.dart';
part 'contacts_state.dart';

const EMPTY_CACHE_MESSAGE = 'There is no contacts yet let\'s add some';

const UNEXPECTED_MESSAGE = 'Unexpected error';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final AddContactUseCase addContactUseCase;
  final GetContactsUseCase getContactsUseCase;

  ContactsBloc({
    required this.getContactsUseCase,
    required this.addContactUseCase,
  }) : super(ContactsState.initial()) {
    on<ContactsEvent>(
      (event, emit) async {
        if (event is GetAllContacts) {
          emit(state.copyWith(contactsStatus: ContactsStatus.loading));
          await Future.delayed(Duration(seconds: 2));
          final result = await getContactsUseCase();
          result.fold((l) {
            if (l is CacheFailure) {
              emit(
                state.copyWith(
                  contacts: [],
                  contactsStatus: ContactsStatus.empty,
                  errorMessage: EMPTY_CACHE_MESSAGE,
                ),
              );
            } else {
              emit(
                state.copyWith(
                  contacts: [],
                  contactsStatus: ContactsStatus.error,
                  errorMessage: UNEXPECTED_MESSAGE,
                ),
              );
            }
          }, (r) {
            final contacts = r;
            emit(state.copyWith(
                contactsStatus: ContactsStatus.loaded, contacts: contacts));
          });
        }
        if (event is AddContact) {
          emit(state.copyWith(contactsStatus: ContactsStatus.loading));
          await Future.delayed(Duration(seconds: 2));
          final result = await addContactUseCase(event.contact);
          result.fold(
            (l) {
              if (l is UnexpectedFailure) {
                emit(
                  state.copyWith(
                    contacts: [],
                    contactsStatus: ContactsStatus.error,
                    errorMessage: UNEXPECTED_MESSAGE,
                  ),
                );
              }
            },
            (r) {
              final contacts = r;
              emit(
                state.copyWith(
                  contactsStatus: ContactsStatus.loaded,
                  contacts: contacts,
                ),
              );
            },
          );
        }
      },
    );
  }
}
