import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_contacts_tdd/domain/entities/contact_entity/contact.dart';
import 'package:save_contacts_tdd/persentation/blox/contacts_bloc/contacts_bloc.dart';

class ContactsScreen extends StatefulWidget {
  ContactsScreen({Key? key}) : super(key: key);

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state.contactsStatus == ContactsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.contactsStatus == ContactsStatus.error) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (state.contactsStatus == ContactsStatus.empty) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final contact = state.contacts[index];
              return ListTile(
                leading: Text('${contact.firstName} ${contact.lastName}'),
              );
            },
            itemCount: state.contacts.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Container(
                  height: 500,
                  padding: EdgeInsets.only(
                      top: 20,
                      right: 15,
                      left: 15,
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('First Name'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: firstNameController,

                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                              hintText: 'First Name',
                              hintStyle: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('Last Name'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: lastNameController,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('Phone Number'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          maxLength: 10,
                          decoration: const InputDecoration(
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                              fontSize: 12,
                            ),
                            counterText: '',
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text('Id'),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: idController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: 'Contact ID',
                              hintStyle: TextStyle(
                                fontSize: 12,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (idController.text.isNotEmpty &&
                                phoneNumberController.text.isNotEmpty &&
                                firstNameController.text.isNotEmpty &&
                                lastNameController.text.isNotEmpty) {
                              final contact = Contact(
                                id: int.parse(idController.text),
                                phoneNumber: phoneNumberController.text,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                              );
                              context.read<ContactsBloc>().add(
                                    AddContact(contact: contact),
                                  );
                              print('added');
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Add Contact'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
    );
  }
}
