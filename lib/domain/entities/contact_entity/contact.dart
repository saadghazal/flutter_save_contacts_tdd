import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int id;

  final String phoneNumber;

  final String firstName;

  final String lastName;

  const Contact({
    required this.id,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
  });

  @override
  String toString() {
    return 'Contact{id: $id, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName}';
  }

  @override
  List<Object> get props => [id, phoneNumber, firstName, lastName];
}
