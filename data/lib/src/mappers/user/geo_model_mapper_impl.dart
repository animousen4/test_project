import 'package:domain/domain.dart';

import '../../entities/user_entity.dart';
import '../entity_mapper.dart';

class GeoModelMapperImpl implements ToModelMapper<GeoModel, GeoEntity> {
  @override
  GeoModel mapToModel(GeoEntity entity) {
    return GeoModel(
      lat: entity.lat,
      lng: entity.lng,
    );
  }
}