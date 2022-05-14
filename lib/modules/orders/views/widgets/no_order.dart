import 'package:flutter/material.dart';
import 'package:social_increase/utils/shared/shared_widget_style.dart';

class NoOrder extends StatelessWidget {
  const NoOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShareWidgetStyle(
      img: 'assets/images/Group 1787.svg',
      title: "You do not have any Order ",
      isSocial: false,
    );
  }
}
