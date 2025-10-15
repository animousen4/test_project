import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../entity_mapper.dart';

class CompanyModelMapper implements ToModelMapper<CompanyModel, CompanyEntity> {
  @override
  CompanyModel mapToModel(CompanyEntity entity) {
    return CompanyModel(
      name: entity.name,
      catchPhrase: entity.catchPhrase,
      bs: entity.bs,
    );
  }
}
