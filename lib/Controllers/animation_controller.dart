// import 'package:flutter/animation.dart';
//
// class AnimationController{
// AnimationController? _controller;
//
// Animation? _profilePictureAnimation;
// Animation? _contentAnimation;
// Animation? _listAnimation;
// Animation? _fabAnimation;
//
// @override
// void initState() {
//   super.initState();
//
// // iconSize goes from 0.0 to 50.0
//   _controller =
//       AnimationController(vsync: this, duration: Duration(seconds: 4));
//   _profilePictureAnimation = Tween(begin: 0.0, end: 50.0).animate(
//       CurvedAnimation(
//           parent: _controller,
//           curve: Interval(0.0, 0.20, curve: Curves.easeOut)));
//
// // fontSize goes from 0.0 to 34.0
//   _contentAnimation = Tween(begin: 0.0, end: 34.0).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(0.20, 0.40, curve: Curves.easeOut)));
//
// // Opacity goes from 0.0 to 1.0
//   _listAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(0.40, 0.75, curve: Curves.easeOut)));
//
// // Fab Size goes from size * 0.0 to size * 1.0
//   _fabAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Interval(0.75, 1.0, curve: Curves.easeOut)));
//   _controller.forward();
//   _controller.addListener(() {
//     setState(() {});
//   });
// }
// }
// void setState(Null Function() param0) {
// }
