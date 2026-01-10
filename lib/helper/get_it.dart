import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fruits/auth/data/repos/auth_repo_impl.dart';
import 'package:fruits/auth/domain/repos/auth_repo.dart';
import 'package:fruits/auth/services/data_service.dart';
import 'package:fruits/auth/services/firebase_auth_service.dart';
import 'package:fruits/auth/services/firestore_service.dart';
import 'package:fruits/repos/product_repo.dart';
import 'package:fruits/repos/product_repo_imp.dart';
import 'package:fruits/services/data_service.dart';
import 'package:fruits/views/home/notification_repo.dart';
import 'package:fruits/views/home/otification_repo_imp.dart';
import 'package:fruits/views/shipping/repos/orders_repo/orders_repo.dart';
import 'package:fruits/views/shipping/repos/orders_repo/orders_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DataService>(FireStoreService());

  getIt.registerSingleton<ProductRepo>(
    ProductRepoImp(dataService: getIt<DataService>()),
  );

  getIt.registerSingleton<OrdersRepo>(
    OrdersRepoImpl(getIt<DataService>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      getIt<FirebaseAuthService>(),
      dataService: getIt<DataService>(),
    ),
  );

  getIt.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(getIt<FirebaseFirestore>()),
  );
}