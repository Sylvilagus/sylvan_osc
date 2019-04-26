///
///Created by Sylva Lee
///
import "package:flutter/material.dart";
import 'package:sylvan_osc/entity/entity.dart';
class CommentItem extends StatelessWidget{
  final Comment comment;

  CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;
    var nameStyle = TextStyle(
        color: primaryColor
    );
    return Material(
      child: Text.rich(TextSpan(
        children: [
          TextSpan(
            text: comment.commentAuthor,
            style: nameStyle
          ),
          TextSpan(text: "："),
          TextSpan(text: comment.content)
        ]
      )),
    );
  }

}