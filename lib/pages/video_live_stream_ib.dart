import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'home_page.dart';

class VideoLiveStreamIb extends StatefulWidget {
  const VideoLiveStreamIb({Key? key}) : super(key: key);

  @override
  _VideoLiveStreamIbState createState() => _VideoLiveStreamIbState();
}

class _VideoLiveStreamIbState extends State<VideoLiveStreamIb> {
  VideoPlayerController? _controller;

  Future setPortrait() async => await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Future setLandscape() async => await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  @override
  void initState() {
    super.initState();
    stopAudioPlayer();
    WakelockPlus.enable();
    _controller = VideoPlayerController.network(
        'https://video.servoserver.com.ng/ifmibadan/livestream.m3u8')
      ..initialize().then((_) {
        _controller!.play();
        setLandscape();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        onTap: (){
          //_showAlertConfirmDelete(context);
          _onWillPop(context);
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: _controller!.value.isInitialized
                ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller!),
                    VideoProgressIndicator(_controller!,
                      allowScrubbing: true,
                    ),
                  ],
                ))
                : const Text('Loading ...', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    setPortrait();
    WakelockPlus.disable();
    _controller!.dispose();
  }

  stopAudioPlayer(){
    HomePage(quizIndex: null, pageIndx: null,).stopAudio();
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        backgroundColor: const Color(0xff264796),
        title: const Text('Inspiration FM Ibadan Studio', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
        content: const Text('Do you really want to quit watching?', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('NO', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
          ),
          TextButton(
            onPressed: () => {
              setPortrait(),
              _controller!.dispose(),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return HomePage(pageIndx: 1);
                  }))
              //Navigator.of(context).pop(true)
            },
            child: const Text('YES', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
          ),
        ],
      ),
    )) ?? false;
  }
}

