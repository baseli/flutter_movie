import 'package:flutter/cupertino.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter_movie/views/chat.dart';
import 'package:flutter_movie/views/video.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final IjkMediaController controller = IjkMediaController();

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.game_controller),
                title: Text('视频')
            ),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.mic),
                title: Text('通话')
            )
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (BuildContext context) {
                  return VideoView(controller: controller);
                },
              );
              break;
            case 1:
              return CupertinoTabView(
                  builder: (BuildContext context) {
                    return ChartView();
                  }
              );
              break;
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
