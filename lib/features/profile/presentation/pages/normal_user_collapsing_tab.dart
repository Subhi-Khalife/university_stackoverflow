import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart' as ex;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:university/core/entities/user.dart';
import 'package:university/core/widget/cached_newtwok_image_view.dart';

class CollapsingNormalUser extends StatefulWidget {
  static const routeName = '/Collapsing_Tab';
  final String userId;
  final List<Widget> tabs;
  final List<Widget> tabsBody;
  final ScrollController scrollController;
  final User user;
  CollapsingNormalUser({
    @required this.userId,
    @required this.tabs,
    @required this.tabsBody,
    @required this.scrollController,
    @required this.user,
  });

  @override
  _CollapsingNormalUser createState() => new _CollapsingNormalUser();
}

class _CollapsingNormalUser extends State<CollapsingNormalUser> with TickerProviderStateMixin {
  TabController primaryTC;
  double size = 40.0;
  double scale = 0.0;
  double constScale = 0.7142857142857143;
  double newScale = 0;
  @override
  void dispose() {
    widget.scrollController.dispose();
    primaryTC.removeListener(tabControlerListener);
    primaryTC.dispose();
    super.dispose();
  }

  int index;

  void tabControlerListener() {
    if (index != primaryTC.index) {
      index = primaryTC.index;
    }
  }

  @override
  void initState() {
    super.initState();
    primaryTC = TabController(length: 2, vsync: this);
    primaryTC.addListener(tabControlerListener);
    widget.scrollController.addListener(() => setState(() {
          print(widget.scrollController.position.maxScrollExtent);
        }));
  }

  double sizeContainerTitle;
  final List<Color> colors = Colors.primaries;
  TextOverflow titleOverFlow = TextOverflow.visible;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ex.NestedScrollView(
          controller: widget.scrollController,
          innerScrollPositionKeyBuilder: () {
            var index = '';
            if (primaryTC.index == 0) {
              index = 'departments';
            } else if (primaryTC.index == 1) {
              index = 'generations';
            } else if (primaryTC.index == 2) {
              index = 'years';
            }
            return Key(index);
          },
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              (true) ? flexibleSpaceWidget() : Container(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Collage:",
                                  style: TextStyle(color: Theme.of(context).accentColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget.user.college.name,
                                  style: TextStyle(color: Theme.of(context).hintColor),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Collage website",
                                  style: TextStyle(color: Theme.of(context).accentColor),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  widget?.user?.college?.site,
                                  style: TextStyle(color: Theme.of(context).hintColor),
                                ),
                                Divider(
                                  thickness: 2,
                                  color: Color(0XFFE5E5E5),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text("Posts number",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context).accentColor)),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(widget?.user?.posts?.length?.toString() ?? "0",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Theme.of(context).hintColor,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: primaryTC,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black26,
                    tabs: widget.tabs,
                    overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                    automaticIndicatorColorAdjustment: true,
                    indicatorColor: Theme.of(context).primaryColor,
                  ),
                ),
                pinned: true,
                key: Key('Posts'),
              ),
            ];
          },
          body: TabBarView(controller: primaryTC, children: [
            ex.NestedScrollViewInnerScrollPositionKeyWidget(
                const Key('departments'), widget.tabsBody[0]),
            ex.NestedScrollViewInnerScrollPositionKeyWidget(
                const Key('generations'), widget.tabsBody[1]),
            // ex.NestedScrollViewInnerScrollPositionKeyWidget(
            //     const Key('years'), widget.tabsBody[2]),
          ])),
    );
  }

  Widget flexibleSpaceWidget() {
    return SliverAppBar(
      expandedHeight: 150.0,
      pinned: true,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: () {},
            ),
            SizedBox(
              width: 10,
            ),
          ],
        )
      ],
      flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          titlePadding: EdgeInsets.only(top: 1, bottom: 10, left: 50, right: 50),
          stretchModes: [StretchMode.blurBackground],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildActionsNew(context),
              SizedBox(
                width: 15,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text(
                          widget.user.firstName + " " + widget.user.lastName,
                          softWrap: true,
                          style: TextStyle(fontSize: 15),
                          overflow: titleOverFlow,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        widget.user.university.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.0, color: Colors.white.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          background: Container(
            padding: EdgeInsets.only(top: 70, left: 15),
            color: Theme.of(context).primaryColor,
          )),
      //   ],
    );
  }

  Widget _buildActionsNew(BuildContext context) {
    Widget profile = new GestureDetector(
      child: new Container(
        height: size,
        width: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(120),
          child: CachedNetworkImageView(
            url: widget?.user?.profilePic ?? "",
            withBaseUrl: false,
            witRaduis: true,
          ),
        ),
      ),
    );

    if (widget.scrollController.hasClients) {
      scale = widget.scrollController.offset / 300;

      scale = scale * 2;

      if (scale >= 0.6) {
        sizeContainerTitle = MediaQuery.of(context).size.width * 0.5;
        newScale = 0.9;
      } else {
        if (scale < 0.3)
          titleOverFlow = TextOverflow.visible;
        else
          titleOverFlow = TextOverflow.ellipsis;
        sizeContainerTitle = MediaQuery.of(context).size.width * 0.3;
        newScale = 1.5 - (scale * constScale);
      }
    } else {
      titleOverFlow = TextOverflow.visible;
      newScale = 1.5;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(newScale, newScale),
      alignment: Alignment.bottomCenter,
      child: profile,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Color(0XFFEFEFEF), // ADD THE COLOR YOU WANT AS BACKGROUND.
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
