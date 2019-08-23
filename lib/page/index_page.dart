import 'package:flutter/material.dart';
import 'package:flutter_mvp/net/entity/response_user_info_entity.dart';
import 'package:flutter_mvp/page/presenter/index_page_presenter.dart';
import 'package:lib_mvp/mvp/base_page_state.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IndexPageState();
  }
}

class IndexPageState extends BasePageState<IndexPage, IndexPagePresenter> {
  String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MVP Framewrok Test"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("server back :${result ?? "click button to request network"}"),
          FlatButton(
              onPressed: () {
                presenter.requestUserInfo();
              },
              child: Text("request user info"))
        ],
      ),
    );
  }

  void updateResponseView(ResponseUserInfoEntity entity) {
    setState(() {
      result = "thanks ${entity?.name??""} - ${entity?.url??""}";
    });
  }

  @override
  IndexPagePresenter createPresenter() {
    return IndexPagePresenter();
  }
}
