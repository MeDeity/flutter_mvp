import 'dart:convert';

import 'package:flutter_mvp/entity_factory.dart';
import 'package:flutter_mvp/net/api.dart';
import 'package:flutter_mvp/net/entity/response_user_info_entity.dart';
import 'package:flutter_mvp/page/index_page.dart';
import 'package:lib_mvp/mvp/base_page_presenter.dart';
import 'package:lib_mvp/network/dio_utils.dart';

class IndexPagePresenter extends BasePagePresenter<IndexPageState>{

  ///请求用户信息
  void requestUserInfo(){
    requestNetwork(Method.get,
      url: Api.users,
      baseUrl: Api.baseUrl,
      onSuccess: (response){
        Map<String,dynamic> _map = json.decode(response?.data.toString());
        String result = json.encode(_map);
        ResponseUserInfoEntity entity = EntityFactory.generateOBJ(_map["data"]);
        view.updateResponseView(entity);
      },
    );
  }
}