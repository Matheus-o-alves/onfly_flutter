// import 'package:onfly_flutter/domain/usecases/save_current_account_usecases.dart';

// import '../../domain/entities/account.entity.dart';
// import '../../domain/helpers/domain_error.dart';
// import '../cache/save_secure_cache_storage.dart';

// class LocalSaveCurrentAccount implements SaveCurrentAccount {
//   late SaveSecureCacheStorage? saveSecureCacheStorage;
//   LocalSaveCurrentAccount({this.saveSecureCacheStorage});

//   Future<void> save(AccountEntity? account) async {
//     try {
//       await saveSecureCacheStorage?.saveSecure(
//           key: 'token', value: account?.token);
//     } catch (error) {
//       throw DomainError.unexpected;
//     }
//   }

//   Future<void> saveUserId(String? password) async {
//     try {
//       await saveSecureCacheStorage?.saveSecure(
//           key: 'password', value: password);
//     } catch (error) {
//       throw DomainError.unexpected;
//     }
//   }

//   Future<void> saveUserPhone(String? user) async {
//     try {
//       await saveSecureCacheStorage?.saveSecure(key: 'user', value: user);
//     } catch (error) {
//       throw DomainError.unexpected;
//     }
//   }
// }
