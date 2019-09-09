import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/page/video/index_video_page.dart';
import 'package:flutter_mvp/page/video/video_list.dart';
import 'package:flutter_mvp/utils/my_utils.dart';
import 'package:lib_mvp/utils/toast_utils.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}

class HomePageState extends State<HomePage> {
  List<String> _titleList = ["首页","专栏","排行","我的"];
  var _pageList;
  var _tabImages;
  ///所选中的索引
  int _selectIndex = 0;
  DateTime  _lastTime;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<bool> _isExit(){
    if (_lastTime == null || DateTime.now().difference(_lastTime) > Duration(milliseconds: 2500)) {
      _lastTime = DateTime.now();
      ToastUtils.show("再次点击退出应用");
      return Future.value(false);
    }
    ToastUtils.cancelToast();
    return Future.value(true);
  }

  void onPageChange(int index){
    if(mounted){
      setState(() {
        _selectIndex = index;
      });
    }
  }

  void initData(){
    _pageList = [
      IndexVideoPage(),
      VideoListPage(),
      IndexVideoPage(),
      IndexVideoPage(),
    ];
    _tabImages = [
      [
        MyUtils.loadAssetImage("home/icon_shop_n"),
        MyUtils.loadAssetImage("home/icon_shop_s"),
      ],
      [
        MyUtils.loadAssetImage("home/icon_sub_n"),
        MyUtils.loadAssetImage("home/icon_sub_s"),
      ],
      [
        MyUtils.loadAssetImage("home/icon_center_n"),
        MyUtils.loadAssetImage("home/icon_center_s"),
      ],
      [
        MyUtils.loadAssetImage("home/icon_center_n"),
        MyUtils.loadAssetImage("home/icon_center_s"),
      ],
    ];
  }

  ///获取TabBar的图标
  Image getTabIcon(int curIndex){
    if(curIndex == _selectIndex){
      return _tabImages[curIndex][1];
    }
    return _tabImages[curIndex][0];
  }

  ///获取TabBar的文本
  Widget getTabText(int curIndex){
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Text(_titleList[curIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: onPageChange,
          children: _pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: List.generate(_titleList.length, (i)=>BottomNavigationBarItem(
            title: getTabText(i),
            icon: getTabIcon(i),
          )),
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectIndex,
          onTap: (index){
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}