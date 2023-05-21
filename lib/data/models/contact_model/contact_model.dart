import 'package:hive/hive.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends Contact {
  @HiveField(0)
  final int modelId;
  @HiveField(1)
  final String modelPhoneNumber;
  @HiveField(2)
  final String modelFirstName;
  @HiveField(3)
  final String modelLastName;
  const ContactModel({
    required this.modelId,
    required this.modelPhoneNumber,
    required this.modelFirstName,
    required this.modelLastName,
  }) : super(
          id: modelId,
          phoneNumber: modelPhoneNumber,
          firstName: modelFirstName,
          lastName: modelLastName,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': modelId,
      'phoneNumber': modelPhoneNumber,
      'firstName': modelFirstName,
      'lastName': modelLastName,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> json) {
    return ContactModel(
      modelId: json['id'] as int,
      modelPhoneNumber: json['phoneNumber'] as String,
      modelFirstName: json['firstName'] as String,
      modelLastName: json['lastName'] as String,
    );
  }
}
