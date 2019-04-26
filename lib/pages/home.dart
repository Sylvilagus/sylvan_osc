/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
import 'new_index.dart';
import 'tweet.dart';
import 'detect.dart';
import 'my.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _position = 0;
  var _pages = [
    IndexPage(),
    TweetPage(),
    DetectPage(),
    MyPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _position);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }
  _bottomNavigationBar(){
    return BottomNavigationBar(
      currentIndex: _position,
      type: BottomNavigationBarType.fixed,
      onTap: (position){
        setState(() {
          _position = position;
        });
        _pageController.animateToPage(_position, duration: Duration(milliseconds: 100), curve: Curves.ease);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("新闻")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.extension),
            title: Text("动弹")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text("发现")
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("我的")
        )
      ],
    );
  }
  _body(){
    return PageView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (buildContext, position){
        return _pages[position];
      },
      controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _position = index;
          });
        }
    );
  }
}
