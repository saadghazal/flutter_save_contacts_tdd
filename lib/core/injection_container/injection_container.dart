import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:save_contacts_tdd/data/data_sources/contacts_data_source/contact_local_data_source.dart';
import 'package:save_contacts_tdd/data/models/contact_model/contact_model.dart';
import 'package:save_contacts_tdd/data/repositories/contact_repository_impl/contact_repository_impl.dart';
import 'package:save_contacts_tdd/domain/repositories/contact_repository/contact_repository.dart';
import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/add_contact_usecase.dart';
import 'package:save_contacts_tdd/domain/usecases/contacts_usecases/get_contacts_usecase.dart';
import 'package:save_contacts_tdd/persentation/blox/contacts_bloc/contacts_bloc.dart';

final sl = GetIt.instance;
Future<void> inject() async {
  //bloc
  sl.registerFactory(
    () => ContactsBloc(
      getContactsUseCase: sl(),
      addContactUseCase: sl(),
    ),
  );

  //usecases
  sl.registerLazySingleton(
    () => GetContactsUseCase(
      contactRepository: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => AddContactUseCase(
      contactRepository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<ContactRepository>(
    () => ContactRepositoryImpl(
      contactLocalDataSource: sl(),
    ),
  );

  //data sources
  sl.registerLazySingleton<ContactLocalDataSource>(
    () => ContactLocalDataSourceImpl(
      contactsBox: sl(),
    ),
  );

  //external
  await Hive.initFlutter();
  Hive.registerAdapter(ContactModelAdapter());
  final contactsBox = await Hive.openBox<ContactModel>(boxName);

  sl.registerLazySingleton<Box>(() => contactsBox);
}
