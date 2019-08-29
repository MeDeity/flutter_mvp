import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/net/entity/response_user_info_entity.dart';
import 'package:flutter_mvp/page/presenter/index_page_presenter.dart';
import 'package:lib_mvp/mvp/base_page_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              child: Text("request user info"))
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
              Text('''
              大概内容如下：
应用分为三部分，精灵列表，技能列表，道具列表；数据从gen1到gen7的究极日月为止。

精灵列表有 按世代，属性，蛋组，努力值进行筛选的功能(努力值筛选只会列出单加你所选属性努力值的精灵)，还可以通过，精灵名称，编号，特性进行搜索(搜索包含精灵的多种形态，例如搜索日照特性能搜索到喷火龙，搜索冰+妖精属性能搜索到九尾)。

精灵具体信息页面有 精灵图片(闪光图没找全就没弄上去了)、名称、属性、捕获度、性别比、初始亲密度、蛋组、孵化步数、属性相性、特性、种族值、每个等级的能力值范围、击败获取的努力值、gen1~gen7的技能表等信息，有多种形态(mega、地区亚种、其他形态等)的精灵还可以进行形态切换。

技能列表，可以通过技能属性和技能类型(物理、特殊、变化)进行筛选，还可以搜索技能名称。

技能详细页面包括技能属性、类型、威力、命中、PP、先至度、特效发动几率、打击面等信息(打击面只是简单的把技能属性打击面信息放过来了，比如什么冷冻干燥对水翻倍、千箭对飞行有效，因为数据的问题我都没能在图鉴上实现，然后变化类技能也别管这个打击面(￣▽￣)"，还有就是技能是否接触、是否可以学舌、是否受魔反影响之类的数据也莫得~，还有就是哪些精灵可以通过什么方式习得该技能这个数据我也没找到现成的。。。)
              ''')
            ],
          ),
        ),
      ),
    );
  }
}
