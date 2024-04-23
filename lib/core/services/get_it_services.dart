import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:tak/core/connection/network_info.dart';
import 'package:tak/core/data/datasources/remote_user_data_source.dart';
import 'package:tak/core/data/repositories/user_repository_impl.dart';
import 'package:tak/core/domain/repositories/user_repository.dart';
import 'package:tak/core/domain/usecases/fetch_user_data_usecase.dart';
import 'package:tak/core/services/secure_storage.dart';
import 'package:tak/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:tak/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tak/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tak/features/auth/domain/repositories/auth_repository.dart';
import 'package:tak/features/auth/domain/usecases/auth.dart';
import 'package:tak/features/auth/domain/usecases/create_account.dart';
import 'package:tak/features/auth/domain/usecases/delete_account_usecase.dart';
import 'package:tak/features/auth/domain/usecases/get_me_usecase.dart';
import 'package:tak/features/auth/domain/usecases/logout.dart';
import 'package:tak/features/auth/domain/usecases/email.dart';
import 'package:tak/features/auth/domain/usecases/verify_otp.dart';
import 'package:tak/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tak/features/messages/data/datasource/message_data_source.dart';
import 'package:tak/features/messages/data/repositories/message_respository_impl.dart';
import 'package:tak/features/messages/domain/respositories/message_respository.dart';
import 'package:tak/features/messages/domain/usecases/get_messages.dart';
import 'package:tak/features/messages/presentation/bloc/message_bloc.dart';
import 'package:tak/features/notification/data/datasource/notification_data_source.dart';
import 'package:tak/features/notification/data/repositories/notification_respository_impl.dart';
import 'package:tak/features/notification/domain/respositories/notification_respository.dart';
import 'package:tak/features/notification/domain/usecases/get_notifications.dart';
import 'package:tak/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:tak/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:tak/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:tak/features/profile/domain/repositories/profile_repository.dart';
import 'package:tak/features/profile/domain/usecases/change_password_usecase.dart';
import 'package:tak/features/profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:tak/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:tak/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tak/features/security/data/datasources/security_datasource.dart';
import 'package:tak/features/security/data/repositories/security_repository_impl.dart';
import 'package:tak/features/security/domain/repositories/security_repositories.dart';
import 'package:tak/features/security/domain/usecases/checkin_usecase.dart';
import 'package:tak/features/security/domain/usecases/checkout_usecase.dart';
import 'package:tak/features/security/domain/usecases/get_security_visitors_usecase.dart';
import 'package:tak/features/security/presentation/bloc/security_bloc.dart';
import 'package:tak/features/service_request/data/datasources/service_request_datasource.dart';
import 'package:tak/features/service_request/data/repositories/service_request_repository_impl.dart';
import 'package:tak/features/service_request/domain/repositories/service_request_repository.dart';
import 'package:tak/features/service_request/domain/usecases/add_request_usecase.dart';
import 'package:tak/features/service_request/domain/usecases/edit_request_usecase.dart';
import 'package:tak/features/service_request/domain/usecases/get_equipment_usecase.dart';
import 'package:tak/features/service_request/domain/usecases/get_service_request_usecase.dart';
import 'package:tak/features/service_request/presentation/bloc/service_request_bloc.dart';
import 'package:tak/features/setup/data/datasources/setup_remote_data_source.dart';
import 'package:tak/features/setup/data/repositories/setup_repository_impl.dart';
import 'package:tak/features/setup/domain/repositories/setup_repository.dart';
import 'package:tak/features/setup/domain/usecases/account_select_usecase.dart';
import 'package:tak/features/setup/domain/usecases/fetch_houses_usecase.dart';
import 'package:tak/features/setup/domain/usecases/select_house_usecase.dart';
import 'package:tak/features/setup/presentation/bloc/setup_bloc.dart';
import 'package:tak/features/transactions/data/datasources/transaction_data_souce.dart';
import 'package:tak/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:tak/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:tak/features/transactions/domain/usecases/get_balance_usecase.dart';
import 'package:tak/features/transactions/domain/usecases/get_invoice_usecase.dart';
import 'package:tak/features/transactions/domain/usecases/get_payment_usecase.dart';
import 'package:tak/features/transactions/domain/usecases/get_rents_usecase.dart';
import 'package:tak/features/transactions/domain/usecases/get_service_charge_usecase.dart';
import 'package:tak/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:tak/features/transactions/presentation/bloc/transaction_bloc.dart';
import 'package:tak/features/visitors/data/datasources/visitor_datasource.dart';
import 'package:tak/features/visitors/data/repositories/visitor_repository_impl.dart';
import 'package:tak/features/visitors/domain/repositories/visitor_repository.dart';
import 'package:tak/features/visitors/domain/usecases/add_visitor_usecase.dart';
import 'package:tak/features/visitors/domain/usecases/edit_visitor_usecase.dart';
import 'package:tak/features/visitors/domain/usecases/get_visitors_usecase.dart';
import 'package:tak/features/visitors/presentation/bloc/visitors_bloc.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
/**
 * -----------------------------------------------------------------------------------------------------------
 */

  //auth
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      createAccountUserCase: getIt(),
      emailUseCase: getIt(),
      verifyOTPUserCase: getIt(),
      logoutUseCase: getIt(),
      loginUseCase: getIt(),
      storage: getIt(),
      deleteAccountUseCase: getIt(),
      getMeUseCase: getIt(),
    ),
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  getIt.registerLazySingleton<FirebaseMessaging>(() => messaging);
  // usescases
  getIt.registerLazySingleton<EmailUseCase>(
      () => EmailUseCase(repository: getIt()));
  getIt.registerLazySingleton<CreateAccountUserCase>(
      () => CreateAccountUserCase(repository: getIt()));
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt()));
  getIt.registerLazySingleton<VerifyOTPUserCase>(
      () => VerifyOTPUserCase(repository: getIt()));
  getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetMeUseCase>(
      () => GetMeUseCase(repository: getIt()));

  getIt.registerLazySingleton<DeleteAccountUseCase>(
      () => DeleteAccountUseCase(repository: getIt()));

  // repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      networkInfo: getIt(),
      localDataSource: getIt(),
      remoteDataSource: getIt(),
      secureStorage: getIt(),
      userDataSource: getIt(),
      messaging: getIt(),
    ),
  );

  //datasources
  final client = http.Client();
  getIt.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl());
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
            client: client,
            secureStorage: getIt(),
          ));

  // network
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //external
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  //storage
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  getIt.registerLazySingleton<UserDataSource>(
      () => UserDataSource(secureStorage: getIt(), client: client));

  getIt.registerLazySingleton<Logger>(() => Logger());

  //setup
  getIt.registerFactory<SetUpBloc>(
    () => SetUpBloc(
      accountSelectUseCase: getIt(),
      selectHouseUseCase: getIt(),
      fetchHousesUseCase: getIt(),
      fetchUserDataUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<AccountSelectUseCase>(
      () => AccountSelectUseCase(repository: getIt()));
  getIt.registerLazySingleton<SelectHouseUseCase>(
      () => SelectHouseUseCase(repository: getIt()));
  getIt.registerLazySingleton<FetchHousesUseCase>(
      () => FetchHousesUseCase(repository: getIt()));
  getIt.registerLazySingleton<FetchUserDataUseCase>(
      () => FetchUserDataUseCase(repository: getIt()));

  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        networkInfo: getIt(),
        remoteDataSource: getIt(),
        secureStorage: getIt(),
      ));
  // repository
  getIt.registerLazySingleton<SetupRepository>(
    () => SetupRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      secureStorage: getIt(),
      userDataSource: getIt(),
    ),
  );

  getIt.registerLazySingleton<SetupRemoteDataSource>(
    () => SetupRemoteDataSourceImp(
      secureStorage: getIt(),
      client: client,
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * service request
   */
  getIt.registerFactory<ServiceRequestBloc>(
    () => ServiceRequestBloc(
      editRequestUseCase: getIt(),
      addRequestUseCase: getIt(),
      getEquipmentUseCase: getIt(),
      getServiceRequestUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<EditRequestUseCase>(
      () => EditRequestUseCase(repository: getIt()));
  getIt.registerLazySingleton<AddRequestUseCase>(
      () => AddRequestUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetEquipmentUseCase>(
      () => GetEquipmentUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetServiceRequestUseCase>(
      () => GetServiceRequestUseCase(repository: getIt()));
  // repository
  getIt.registerLazySingleton<ServiceRequestRepository>(
    () => ServiceRequestRepositoryImpl(
      networkInfo: getIt(),
      secureStorage: getIt(),
      dataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<ServiceRequestDataSource>(
    () => ServiceRequestDataSourceImp(
      client: client,
      secureStorage: getIt(),
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * Visitor
   */
  getIt.registerFactory<VisitorsBloc>(
    () => VisitorsBloc(
      editVisitorUseCase: getIt(),
      addVisitorUseCase: getIt(),
      getVisisotrsUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<EditVisitorUseCase>(
      () => EditVisitorUseCase(repository: getIt()));
  getIt.registerLazySingleton<AddVisitorUseCase>(
      () => AddVisitorUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetVisitorsUseCase>(
      () => GetVisitorsUseCase(repository: getIt()));

  // repository
  getIt.registerLazySingleton<VisitorRepository>(
    () => VisitorRepositoryImpl(
      networkInfo: getIt(),
      secureStorage: getIt(),
      dataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<VisitorDataSource>(
    () => VisitorDataSourceImpl(
      client: client,
      secureStorage: getIt(),
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * Security
   */
  getIt.registerFactory<SecurityBloc>(
    () => SecurityBloc(
      visitorsUseCase: getIt(),
      checkinUseCase: getIt(),
      checkoutUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<GetSecurityVisitorsUseCase>(
      () => GetSecurityVisitorsUseCase(repository: getIt()));
  getIt.registerLazySingleton<CheckOutUseCase>(
      () => CheckOutUseCase(repository: getIt()));
  getIt.registerLazySingleton<CheckInUseCase>(
      () => CheckInUseCase(repository: getIt()));
  // repository
  getIt.registerLazySingleton<SecurityRepository>(
    () => SecurityRepositoryImpl(
      networkInfo: getIt(),
      secureStorage: getIt(),
      dataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<SecurityDataSource>(
    () => SecurityDataSourceImpl(
      client: client,
      secureStorage: getIt(),
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * Transaction
   */
  getIt.registerFactory<TransactionBloc>(
    () => TransactionBloc(
      getBalanceUseCase: getIt(),
      getInvoicesUseCase: getIt(),
      getPaymentsUseCase: getIt(),
      getRentsUseCase: getIt(),
      getServiceChargeUseCase: getIt(),
      getTransactionsUseCase: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<GetBalanceUseCase>(
      () => GetBalanceUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetInvoicesUseCase>(
      () => GetInvoicesUseCase(repository: getIt()));
  getIt.registerLazySingleton<GetPaymentsUseCase>(
      () => GetPaymentsUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetRentsUseCase>(
      () => GetRentsUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetServiceChargeUseCase>(
      () => GetServiceChargeUseCase(repository: getIt()));

  getIt.registerLazySingleton<GetTransactionsUseCase>(
      () => GetTransactionsUseCase(repository: getIt()));

  // repository
  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(
      networkInfo: getIt(),
      secureStorage: getIt(),
      remoteDataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<TransactionDataSource>(
    () => TransactionDataSourceImpl(
      client: client,
      secureStorage: getIt(),
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * Notifications
   */
  getIt.registerFactory<NotificationBloc>(
    () => NotificationBloc(
      getNotifications: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<GetNotifications>(
      () => GetNotifications(repository: getIt()));
  // repository
  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImp(
      networkInfo: getIt(),
      secureStorage: getIt(),
      dataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<NotificationDataSource>(
    () => NotificationDataSourceImpl(
      client: client,
      secureStorage: getIt(),
    ),
  );

  /**
   * -----------------------------------------------------------------------------------------------------------
   * Messages
   */
  getIt.registerFactory<MessageBloc>(
    () => MessageBloc(
      getMessages: getIt(),
    ),
  );

  // usescases
  getIt.registerLazySingleton<GetMessages>(
      () => GetMessages(repository: getIt()));
  // repository
  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImp(
      networkInfo: getIt(),
      secureStorage: getIt(),
      dataSource: getIt(),
    ),
  );

  //datasources
  getIt.registerLazySingleton<MessageDataSource>(
    () => MessageDataSourceImpl(
      client: client,
      secureStorage: getIt(),
    ),
  );

  // Profile ------------------------------------------------------------------
  // profile instance
  getIt.registerFactory<ProfileBloc>(() => ProfileBloc(
        updateProfileUseCase: getIt(),
        updateProfileImageUseCase: getIt(),
        changePasswordUseCase: getIt(),
      ));
  //usecase
  getIt.registerLazySingleton<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(repository: getIt()));
  getIt.registerLazySingleton<UpdateProfileImageUseCase>(
      () => UpdateProfileImageUseCase(repository: getIt()));
  getIt.registerLazySingleton<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(repository: getIt()));
  //repository
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      networkInfo: getIt(),
      remoteDataSource: getIt(),
      secureStorage: getIt(),
      userDataSource: getIt(),
    ),
  );

  //remote data source
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(client: client, secureStorage: getIt()),
  );
}
