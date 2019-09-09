
import 'package:flutter/material.dart';
import 'package:flutter_mvp/page/video/video_list.dart';
import 'package:flutter_mvp/utils/my_utils.dart';
import 'package:lib_mvp/res/resources.dart';


class IndexVideoPage extends StatefulWidget {
  @override
  _IndexVideoPageState createState() => _IndexVideoPageState();
}

class _IndexVideoPageState extends State<IndexVideoPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin{


  TabController _tabController;
  PageController _pageController = PageController(initialPage: 0);
  var _isPageCanChanged = true;
  var _index = 0;
  var _sortIndex = 0;

  GlobalKey _addKey = GlobalKey();
  GlobalKey _bodyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: (){
//              NavigatorUtils.push(context, GoodsRouter.goodsSearchPage);
            },
            icon: MyUtils.loadAssetImage(
              "goods/search",
              width: 24.0,
              height: 24.0,
            ),
          ),
          IconButton(
            key: _addKey,
            onPressed: (){
//              _showAddMenu();
            },
            icon: MyUtils.loadAssetImage(
              "goods/add",
              width: 24.0,
              height: 24.0,
            ),
          )
        ],
      ),
      body: Column(
        key: _bodyKey,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: TabBar(
              onTap: (index){
                if (!mounted){
                  return;
                }
                _pageController.jumpToPage(index);
              },
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyles.textBoldDark18,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.only(left: 16.0),
              unselectedLabelColor: Colours.text_dark,
              labelColor: Colours.app_main,
              indicatorPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
              tabs: <Widget>[
                Tab(
                    child: Container(
                      width: 50.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("精选"),
                        ],
                      ),
                    )
                ),
                Tab(
                    child: Container(
                      width: 50.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("VIP"),
                        ],
                      ),
                    )
                ),
                Tab(
                    child: Container(
                      width: 50.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("国产"),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
          Gaps.line,

          Expanded(
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (index) {
                if (_isPageCanChanged) {//由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                  _onPageChange(index);
                }
              },
              controller: _pageController,
              itemBuilder: (BuildContext context, int index) {
                return VideoListPage();
//              return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  _onPageChange(int index, {PageController p, TabController t}) async {

    if (p != null) {//判断是哪一个切换
      _isPageCanChanged = false;
      await _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);//切换Tabbar
    }
    setState(() {
      _index = index;
    });
  }


  @override
  bool get wantKeepAlive => true;
}
