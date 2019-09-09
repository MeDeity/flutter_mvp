import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_mvp/page/widget/search_bar_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lib_mvp/utils/toast_utils.dart';

class VideoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoListPageState();
  }
}

class VideoListPageState extends State<VideoListPage> {
  // 条目总数
  int _count = 20;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      body: EasyRefresh.builder(
        builder: (context, physics, header, footer) {
          return CustomScrollView(
            physics: physics,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 100.0,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(
                    'Swiper',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              header,
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 100,
                    child: SearchBarView(
                      isHideCity:true,
                      isHideInputTextLeftIcon: true,
                      isHideInputTextRightIcon: true,
                      height: 35,
                      searchBarType: SearchBarType.home,
                      inputBoxClick: () {
                        ToastUtils.show("准备搜索吧...");
                      },
                      defaultText: "请输入文字",
                      leftButtonOnClick: () {
                        // _jumpToCity(context);
                      },
                      customActions: [
                        WrapTapView(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.message,
                              size: 24,
                            ),
                          ),
                          callback: (){
                            ToastUtils.show("测试");
                          },
                        ),
                        WrapTapView(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.message,
                              size: 24,
                            ),
                          ),
                          callback: (){
                            ToastUtils.show("测试");
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 210.0,
                    child: ScrollNotificationInterceptor(
                      child: Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            "http://via.placeholder.com/288x188",
                            fit: BoxFit.fill,
                          );
                        },
                        itemCount: 10,
                        viewportFraction: 0.8,
                        scale: 0.9,
                        outer: true,
                        pagination: SwiperPagination(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              activeColor: Colors.yellowAccent,
                              color: Colors.grey,
                              activeSize: 10),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Text("test");
                }, childCount: _count),
              ),
              footer,
            ],
          );
        },
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _count = 20;
            });
          });
        },
        onLoad: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {
              _count += 20;
            });
          });
        },
      ),
    );
  }
}
