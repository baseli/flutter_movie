import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/util/settings.dart';
import 'package:flutter_movie/widget/float.dart';
import 'package:permission_handler/permission_handler.dart';

class ChartView extends StatefulWidget {

  @override
  ChartViewState createState() => ChartViewState();
}

class ChartViewState extends State<ChartView> {
  static OverlayEntry entry;
  RtcEngine _rtcEngine;
  bool _joined = false;

  _init() async {
    await [Permission.camera, Permission.microphone, Permission.storage].request();

    _rtcEngine = await RtcEngine.create(Settings.AGORA_APP_ID)..enableAudio();
    _rtcEngine.setChannelProfile(ChannelProfile.Communication);
    _rtcEngine.enableLocalAudio(true);

    _rtcEngine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print(channel);
        setState(() {
          _joined = true;
        });
      },
      userOffline: (int uid, UserOfflineReason reason) {
        setState(() {
          _joined = false;
        });
      },
      error: (ErrorCode code) {
        print(code);
      }
    ));

    await _rtcEngine.joinChannel('00628422af3a0314758b9203f6bafd7995cIACAxTFpG/2S4dlVUmCodQCu/xeITSQUilT+k4NSqJE6AtJjSIgAAAAAEABbs5GVYcOCXwEAAQBiw4Jf', '123', null, 0);
  }

  ChartViewState() {
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _joined ? _buildChatWidget(context) : _buildJoinWidget(context),
    );
  }

  _buildJoinWidget(BuildContext context) {
    return CupertinoButton.filled(
      child: Text('加入'),
      onPressed: () {
        entry?.remove();
        entry = null;
        entry = OverlayEntry(
          builder: (BuildContext context) {
            return FloatWidget();
          }
        );
        Overlay.of(context).insert(entry);
      },
    );
  }

  _buildChatWidget(BuildContext context) {
    return const Text('已经加入');
  }
}
