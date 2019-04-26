/**
 * Created by Sylva Lee
 */

import 'package:flutter/material.dart';
mixin SliverAppBarMixin{
  String get titleName;
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: headerSliverBuilder, body: createBody());
  }
  List<Widget> headerSliverBuilder(
      BuildContext buildContext, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        title: Text(titleName),
      )
    ];
  }
  Widget createBody();
}