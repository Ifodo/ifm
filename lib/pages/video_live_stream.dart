import 'package:inspiration/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class VideoLiveStream extends StatefulWidget {
  const VideoLiveStream({Key? key}) : super(key: key);

  @override
  _VideoLiveStreamState createState() => _VideoLiveStreamState();
}

class _VideoLiveStreamState extends State<VideoLiveStream> {
  VideoPlayerController? _controller;

  Future setPortrait() async => await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Future setLandscape() async => await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  Future setPortraitAndLandscape() =>
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);


  @override
  void initState() {
    super.initState();
    stopAudioPlayer();
    WakelockPlus.enable();

    _controller = VideoPlayerController.network(
        'https://ngvid.elektranbroadcast.com/hls/ifm923/mystream.m3u8')
      ..initialize().then((_) {
        _controller!.play();
        setLandscape();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: MaterialApp(
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
                      //_ControlsOverlay(controller: _controller!),
                      VideoProgressIndicator(_controller!,
                        allowScrubbing: true,
                      ),
                    ],
                  ))
                  : const Text('Loading ...', style: TextStyle(color: Colors.white)),
            ),
            /*floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),*/
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
        title: const Text('Inspiration FM Lagos Studio', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
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
                    return HomePage(pageIndx: 0);
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




class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
            color: Colors.white,
            child: const Center(
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 100.0,
                semanticLabel: 'Play',
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
