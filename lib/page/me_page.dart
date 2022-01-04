import 'package:cooper/content/navigation_constants.dart';
import 'package:cooper/navi/navigation_service.dart';
import 'package:cooper/utils/adapt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MePage extends StatefulWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  State<MePage> createState() => _MeState();
}

class _MeState extends State<MePage> {
  final Map<Icon,String> _itemList= {
    const Icon(Icons.http_sharp):"我的发布",
    const Icon(Icons.assistant_photo):"收藏",
    const Icon(Icons.hourglass_bottom_rounded):"关于",
  };

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: TextButton(onPressed:(){
                NavigationService.instance.navigateToPage(path:NavigationConstants.LOGIN);
              } ,child: const Text("注册/登录" ,style: TextStyle(color: Colors.white,fontSize:15),),),
              centerTitle: true,
              background: Image.asset('images/test.jpg' ,fit: BoxFit.fill,),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 230.0,
            backgroundColor: Colors.cyan,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 5,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () {
                  print("更多");
                },
              ),
            ],
          ),
         SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                  leading:_itemList.keys.elementAt(index),
                  title: Text(_itemList.values.elementAt(index)),
              ),
              childCount: _itemList.length,
            ), itemExtent: 50,
          ),
          const SliverFillRemaining(),
        ],
      ),
    );
  }
}
