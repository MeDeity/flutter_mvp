import 'package:flutter/material.dart';

enum SearchBarType { home, normal, homeLight }

class SearchBarView extends StatefulWidget {
  ///城市名称,一般用在LBS社交性应用上
  final String city;

  ///是否显示地理位置
  final bool isHideCity;

  /// 是否隐藏输入框左侧的图标
  final bool isHideInputTextLeftIcon;

  /// 是否隐藏输入框右侧的图标
  final bool isHideInputTextRightIcon;
  final bool enabled;
  final bool hideLeft;
  final SearchBarType searchBarType;
  final String hint;

  ///默认的文字提示
  final String defaultText;

  ///左侧按钮事件
  final void Function() leftButtonOnClick;

  ///右侧按钮事件
  final void Function() rightButtonOnClick;

  ///语音输入
  final void Function() speakClick;

  ///输入框事件
  final void Function() inputBoxClick;

  ///输入监听
  final ValueChanged<String> onChanged;

  ///自定义按钮事件
  final List<WrapTapView> customActions;

  ///控件高度
  final double height;

  const SearchBarView({Key key,
    this.height: 50,
    this.enabled = true,
    this.isHideCity: false,
    this.hideLeft: false,
    this.isHideInputTextLeftIcon: false,
    this.isHideInputTextRightIcon: false,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonOnClick,
    this.rightButtonOnClick,
    this.speakClick,
    this.inputBoxClick,
    this.onChanged,
    this.customActions,
    this.city = '北京'})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarView> {
  bool _showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.defaultText != null) {
      setState(() {
        _controller.text = widget.defaultText;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal
        ? _genNormalSearch()
        : _genHomeSearch();
  }

  _genNormalSearch() {
    return Row(
      children: <Widget>[
        wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(6, 5, 10, 5),
              child: widget?.hideLeft ?? false == false
                  ? null
                  : Icon(
                Icons.arrow_back,
                size: 26,
                color: Colors.grey,
              ),
            ),
            widget.leftButtonOnClick),
        Expanded(
          flex: 1,
          child: _initEditText(),
        ),
        wrapTap(
            Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                '搜索',
                style: TextStyle(color: Colors.blueAccent, fontSize: 17),
              ),
            ),
            widget.rightButtonOnClick)
      ],
    );
  }

  ///首页搜索框控件
  Widget _genHomeSearch() {
    return Row(
      children: <Widget>[
        Offstage(
          offstage: widget.isHideCity,
          child: wrapTap(
              Container(
                padding: EdgeInsets.fromLTRB(6, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: widget.height,
                      child: Text(
                        widget.city,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: _homeFontColor(), fontSize: 14),
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: _homeFontColor(),
                      size: 22,
                    ),
                  ],
                ),
              ),
              widget.leftButtonOnClick),
        ),
        Expanded(
          flex: 1,
          child: _initEditText(),
        ),
        (null != widget.customActions) ? Row(
          children: widget.customActions.toList(),
        ) : SizedBox(),
      ],
    );
  }

  ///点击事件封装
  wrapTap(Widget child, void Function() callback) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }

  ///输入框构建
  Widget _initEditText() {
    Color edtBackgroundColor;
    if (widget.searchBarType == SearchBarType.home) {
      edtBackgroundColor = Colors.grey[200];
    } else {
      edtBackgroundColor = Color(0xffEDEDED);
    }
    return Container(
      height: widget.height,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          color: edtBackgroundColor,
          borderRadius: BorderRadius.circular(
              widget.searchBarType == SearchBarType.normal ? 5 : 15)),
      child: Row(
        children: <Widget>[
          Offstage(
            offstage: widget.isHideInputTextLeftIcon,
            child: Icon(
              Icons.search,
              size: 20,
              color: widget.searchBarType == SearchBarType.normal
                  ? Color(0xffA9A9A9)
                  : Colors.blueAccent,
            ),
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
                ? TextField(
              controller: _controller,
              onChanged: _onChanged,
              autofocus: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  icon: Icon(Icons.search,size: 26,),
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  border: InputBorder.none,
                  labelText: widget.hint ?? '',
                  hintText: widget.hint ?? '',
                  hintStyle: TextStyle(fontSize: 15)),
            )
                : wrapTap(
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.defaultText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.grey,),
                      ),
                      Icon(
                        Icons.search,
                        size: 19,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                widget.inputBoxClick),
          ),
          !_showClear
              ? Offstage(
            offstage: widget.isHideInputTextRightIcon,
            child: wrapTap(
                Icon(
                  Icons.mic,
                  size: 22,
                  color: widget.searchBarType == SearchBarType.normal
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
                widget.speakClick),
          )
              : wrapTap(
              Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey,
              ), () {
            setState(() {
              _controller.clear();
              _onChanged('');
            });
          })
        ],
      ),
    );
  }

  void _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        _showClear = true;
      });
    } else {
      setState(() {
        _showClear = false;
      });
    }
    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight
        ? Colors.black54
        : Colors.white;
  }
}

class WrapTapView extends StatelessWidget {
  final Widget child;
  final void Function() callback;

  WrapTapView({@required this.child, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: child,
    );
  }
}
