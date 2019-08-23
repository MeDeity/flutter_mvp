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
        title: Text("MVP框架使用测试"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text("服务器返回值:${result ?? "请点击请求网络查看此数据是否发生变化"}"),
          FlatButton(
              onPressed: () {
                presenter.requestUserInfo();
              },
              child: Text("点击请求网络"))
        ],
      ),
    );
  }

  void updateResponseView(ResponseUserInfoEntity entity) {
    setState(() {
      result = "致谢${entity?.name??"神秘大佬"} - ${entity?.url??"神游远方"}";
    });
  }

  @override
  IndexPagePresenter createPresenter() {
    return IndexPagePresenter();
  }
}
