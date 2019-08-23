import 'package:flutter_mvp/net/entity/response_user_info_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ResponseUserInfoEntity") {
      return ResponseUserInfoEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}