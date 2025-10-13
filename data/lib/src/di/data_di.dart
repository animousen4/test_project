import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:retrofit/error_logger.dart';

import '../../data.dart';
import '../entities/user_entity.dart';
import '../mappers/entity_mapper.dart';
import '../mappers/user/company_model_mapper_impl.dart';
import '../mappers/user/geo_model_mapper_impl.dart';
import '../mappers/user/user_address_mapper_impl.dart';
import '../providers/user_api_provider.dart';
import '../repositories/user_repository_impl.dart';

abstract class DataDI {
  static void initDependencies(GetIt locator) {
    _initApi(locator);
    _initProviders(locator);
    _initRepositories(locator);
  }

  static void _initApi(GetIt locator) {
    locator.registerLazySingleton<DioConfig>(
      () => DioConfig(
        appConfig: locator<AppConfig>(),
      ),
    );

    locator.registerLazySingleton<ErrorHandler>(
      () => ErrorHandler(
        eventNotifier: locator<AppEventNotifier>(),
      ),
    );

    locator.registerLazySingleton<ApiProvider>(
      () => ApiProvider(
        locator<DioConfig>().dio,
      ),
    );
  }

  static void _initProviders(GetIt locator) {
    locator.registerLazySingleton<UserApiProvider>(
      () => UserApiProvider(
        locator<DioConfig>().dio,
        baseUrl: locator<AppConfig>().baseUrl,
        errorLogger: locator<ParseErrorLogger>(),
      ),
    );

    locator.registerLazySingleton<ToModelMapper<UserModel, UserEntity>>(
      () => UserModelMapperImpl(
        addressMapper: UserAddressMapperImpl(geoMapper: GeoModelMapperImpl()),
        companyMapper: CompanyModelMapperImpl(),
      ),
    );

    locator.registerLazySingleton<ToModelMapper<CompanyModel, CompanyEntity>>(
      CompanyModelMapperImpl.new,
    );
  }

  static void _initRepositories(GetIt locator) {
    locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userApi: locator<UserApiProvider>(),
        userMapper: locator<ToModelMapper<UserModel, UserEntity>>(),
      ),
    );
  }
}
