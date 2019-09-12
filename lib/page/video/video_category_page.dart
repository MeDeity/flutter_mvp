import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvp/page/widget/animated_provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///
///视频分类显示页面
///create by fengwenhua at 2019-9-12 11:33:55
///
class VideoCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoCategoryPageState();
  }
}

class VideoCategoryPageState extends State<VideoCategoryPage> with TickerProviderStateMixin{
  CustomScrollController _scrollController;
  TabController _tabController;
  bool isDisplay = false;


  @override
  void initState() {
    super.initState();
    _scrollController = CustomScrollController();
    _scrollController.addListener(() {
//      print("${_scrollController.offset}"); //当前滚动的位置
//      _scrollController.jumpToItem(_scrollController.offset);
      if (_scrollController.offset > 10) {
        print("显示");
        setState(() {
          isDisplay = true;
        });
      } else {
        print("不显示");
        setState(() {
          isDisplay = false;
        });
      }

    });
    _tabController = TabController(vsync: this,length: 2);
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
//            centerTitle: true,
//            title: Text("12312312312312312"),
            actions: <Widget>[
              EmptyAnimatedSwitcher(
                display: isDisplay,
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: BannerWidget(),
              centerTitle: true,
              title: EmptyAnimatedSwitcher(
                display: isDisplay,
                child: Text("测试"),
              ),
            ),
            expandedHeight: 180,
            pinned: true,
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _MySliverPersistentHeaderDelegate(TabBar(
                controller:_tabController,
                isScrollable: true,
                indicatorColor:Colors.yellow,//指示器的颜色
                indicatorWeight:5,
//                indicatorPadding: const EdgeInsets.all(20),
                labelColor:Colors.purpleAccent,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Colors.grey,
                dragStartBehavior:DragStartBehavior.down,
                tabs:[
                  Tab(
                    text: "测试1",
                  ),
                  Tab(
                    text: "测试2",
                  ),
                ],
            )),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                Text("12343"),
                Text("12343")
              ],
            ),
          ),
//          SliverList(
//            delegate: SliverChildBuilderDelegate((BuildContext context,
//                int index) {
//              return Text("$index");
//            }, childCount: 100),
//          ),
        ],
      ),
    );
  }
}

class _MySliverPersistentHeaderDelegate<T extends PreferredSizeWidget>
    extends SliverPersistentHeaderDelegate {
  T widget;
  Color backgroundColor;

  _MySliverPersistentHeaderDelegate(this.widget,{this.backgroundColor:Colors.white});

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: widget,
    );
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}

class CustomScrollController extends ScrollController {
  CustomScrollController({
    double initialScrollOffset = 0.0,
    keepScrollOffset = true,
    debugLabel,
  }) : super(
      initialScrollOffset: initialScrollOffset,
      keepScrollOffset: keepScrollOffset,
      debugLabel: debugLabel);

  void jumpToItem(double value) {
    assert(positions.isNotEmpty, 'ScrollController not attached.');
    for (ScrollPosition position in List<ScrollPosition>.from(positions)) {
//      print("当前位置:${position.pixels}");
    }
  }
}


List<String> images = [
  "http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",
  "http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",
  "http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",
  "http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",
  "http://pic16.nipic.com/20111006/6239936_092702973000_2.jpg",
];

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme
                .of(context)
                .scaffoldBackgroundColor,
          ),
          child: Swiper(
            loop: true,
            autoplay: true,
            autoplayDelay: 5000,
            pagination: SwiperPagination(),
            itemCount: images.length,
            itemBuilder: (ctx, index) {
              return InkWell(
                  onTap: () {}, child: BannerImage(images[index]));
            },
          )),
    );
  }
}

class BannerImage extends StatelessWidget {
  final String url;
  final BoxFit fit;

  BannerImage(this.url, {this.fit: BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) =>
            Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: fit);
  }
}
