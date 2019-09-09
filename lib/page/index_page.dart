import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/net/entity/response_user_info_entity.dart';
import 'package:flutter_mvp/page/presenter/index_page_presenter.dart';
import 'package:flutter_mvp/page/video/home_page.dart';
import 'package:lib_mvp/mvp/base_page_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:lib_mvp/router/app_navigator.dart';

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
          _buildImageItem(),
          Text("server back :${result ?? "click button to request network"}"),
          FlatButton(
              onPressed: () {
                presenter.requestUserInfo();
              },
              child: Text("request user info")),
          FlatButton(
              onPressed: () {
                AppNavigator.push(context, HomePage());
              },
              child: Text("首页")),
        ],
      ),
    );
  }

  void updateResponseView(ResponseUserInfoEntity entity) {
    setState(() {
      result = "thanks ${entity?.name ?? ""} - ${entity?.url ?? ""}";
    });
  }

  @override
  IndexPagePresenter createPresenter() {
    return IndexPagePresenter();
  }

  ///
  Widget _buildImageItem() {
    return Material(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: Divider.createBorderSide(context, width: 0.7),
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: "http://www.baidu.com",
                      placeholder: (BuildContext context, String url){
                        return SizedBox(
                            width: 20, height: 20, child: CupertinoActivityIndicator(
                            radius: (20/3)
                        ));
                      },
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("xxxxxxx"),
                  ),
                  Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Text("2019-8-29 17:44:50")
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
