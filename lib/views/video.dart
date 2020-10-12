import 'package:flutter/cupertino.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_movie/util/parseVideo.dart';
import 'dart:async';

class VideoView extends StatefulWidget {
  IjkMediaController controller;


  VideoView({@required this.controller}) {
    controller.setNetworkDataSource("http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8");
  }

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final IjkMediaController controller = IjkMediaController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // controller.setNetworkDataSource('https://omts.tc.qq.com//AaJlIiYfRhiKpZnL1aYPFzqzBVyK37wbQQVSPZz2KYUs/uwMROfz2r5xgoaQXGdGnC2df64gVTKzl5C_X6A3JOVT0QIb-/DSPLEqR8kSNAnrruSl6Jpf4Ufv02k4bnY-zEbl_oPTDQSjHVuAMqQkEh10kkgu5gTyK7X-IFaJ46T9QPPyEwlcnDbPy335eVKQPfKSOEspcdaSDxZU4BIJyJIZn3JaHRNpsiSnOjsg5QbbCsUNFBTQ/l00349gr3gj.321004.ts.m3u8?ver=4');

    return CupertinoPageScaffold(
      child: Container(
        height: size.width * 9 / 16,
        child: IjkPlayer(
          mediaController: controller,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
