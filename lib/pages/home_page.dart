import 'package:inspiration/pages/podcast_lagos.dart';
import 'package:inspiration/widgets/submit_quiz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:inspiration/pages/contact.dart';
import 'package:inspiration/pages/ifm_lagos.dart';
import 'package:inspiration/pages/ifm_uyo.dart';
import 'package:inspiration/pages/my_drawer.dart';
import 'package:inspiration/pages/news_page.dart';
import 'package:inspiration/pages/oaps_select.dart';
import 'package:inspiration/pages/quiz.dart';
import 'package:inspiration/pages/wft_page.dart';
import 'package:inspiration/widgets/events.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_radio_player/flutter_radio_player.dart';
import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  var volume = 1.0;
  var streamPlaying = 'Live Stream';

  int? pageIndx;
  int? quizIndex;

  HomePage({Key? key, @required this.pageIndx, @required this.quizIndex})
      : super(key: key);

  stopAudio() {
    final player = AudioPlayer();
    player.stop();
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _player = AudioPlayer();

  //late BannerAd _bottomBannerAd;
  final bool _isBottomBannerAdLoaded = false;

  /*void _createBottomBannerAd() {
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }*/

  @override
  void initState() {
    super.initState();
    _init();
    //_createBottomBannerAd();
  }

  @override
  void dispose() {
    super.dispose();
    //_bottomBannerAd.dispose();
  }

  Future<void> _init() async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse("https://azstream.elektranbroadcast.com/listen/ifm923/radio.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  Future<void> _initUy() async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(AudioSource.uri(
          Uri.parse("https://azstream.elektranbroadcast.com/listen/ifm1059/radio.mp3")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  int index = 0;
  List<Widget> list = [
    const IFMLagos(),
    const IFMUyo(),
    const NewsPage(),
    WFTPage(),
    const PodcastLagos(),
    const OAPsSelect(),
    const Events(),
    const Quiz(),
    const Contact(),
    const SubmitQuiz()
  ];
  String pageName = 'Home';
  int? pageIndex;
  String? businessLocation;

  @override
  Widget build(BuildContext context) {
    setState(() {
      switch (widget.pageIndx) {
        case 0:
          {
            //_flutterRadioPlayer.stop();
            pageName = 'Lagos 92.3 FM';
            index = widget.pageIndx!;
            businessLocation = 'Lagos';
            //initRadioService();
            _init();
            widget.streamPlaying = 'Live Stream Lagos';
          }
          break;
        case 1:
          {
            //_flutterRadioPlayer.stop();
            pageName = 'Uyo 105.9 FM';
            index = widget.pageIndx!;
            businessLocation = 'Uyo';
            _initUy();
            widget.streamPlaying = 'Live Stream Uyo';
          }
          break;
        case 7:
          {
            pageName = 'Quiz';
            index = widget.pageIndx!;
          }
          break;
        case 8:
          {
            pageName = 'Quiz';
            index = widget.pageIndx!;
          }
          break;
      }
    });
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    //var businessLocation = 'Lagos';
    return PopScope(
      canPop: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 75.0,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset('assets/menu_72c.png'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            /*actions: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: Image.asset('assets/menu_icon_small.png'),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
                ],
              ),

            ],*/
            title: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Container(
                        width: 130,
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: const DecorationImage(
                                image:
                                    AssetImage('assets/logo_general_small.png'))),
                      ),
                    ),
                    /*Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(pageName,
                            style: TextStyle(
                                color: Color(0xff2a166f),
                                fontSize: 21,
                                fontWeight: FontWeight.bold))
                    )*/
                  ]),
            ),
          ),

          drawer: MyDrawer(onTap: (ctx, i) {
            setState(() {
              index = i;
              switch (index) {
                case 0:
                  {
                    //_flutterRadioPlayer.stop();
                    pageName = 'Lagos 92.3 FM';
                    index = 0;
                    businessLocation = 'Lagos';
                    widget.pageIndx = index;
                    _init();
                  }
                  break;
                case 1:
                  {
                    //_flutterRadioPlayer.stop();
                    pageName = 'Uyo 105.9 FM';
                    index = 1;
                    businessLocation = 'Uyo';
                    widget.pageIndx = index;
                    _initUy();
                  }
                  break;
                case 2:
                  {
                    pageName = 'News';
                    index = 2;
                    widget.pageIndx = index;
                  }
                  break;
                case 3:
                  {
                    pageName = 'The Word For Today';
                    index = 3;
                    widget.pageIndx = index;
                  }
                  break;
                case 4:
                  {
                    pageName = 'Podcast Lagos';
                    index = 4;
                    widget.pageIndx = index;
                  }
                  break;
                case 5:
                  {
                    pageName = 'On Air Personalities';
                    index = 5;
                    widget.pageIndx = index;
                  }
                  break;
                case 6:
                  {
                    pageName = 'Events';
                    index = 6;
                    widget.pageIndx = index;
                  }
                  break;
                case 7:
                  {
                    pageName = 'Quiz';
                    index = 7;
                    widget.pageIndx = index;
                  }
                  break;
                case 8:
                  {
                    pageName = 'Contact';
                    index = 8;
                    widget.pageIndx = index;
                  }
                  break;
              }
              Navigator.pop(ctx);
            });
          }),
          body: list[index],
          persistentFooterButtons: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xff264796), Color(0xff2a166f)],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Container(
                  height: 85,
                  width: screenWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left side - Contact icons
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildContactButton(
                            onPressed: () => showAlertDialogWhatsapp(context),
                            icon: Image.asset('assets/whatsapp.png', width: 24, height: 24),
                          ),
                          const SizedBox(width: 4),
                          _buildContactButton(
                            onPressed: () => showAlertDialog(context),
                            icon: const Icon(Icons.call_rounded, color: Colors.white, size: 24),
                          ),
                          const SizedBox(width: 4),
                          _buildContactButton(
                            onPressed: () => showAlertDialogSendMail(context),
                            icon: const Icon(Icons.mail_rounded, color: Colors.white, size: 24),
                          ),
                        ],
                      ),

                      // Center - Station info
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffb30622),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xffb30622).withOpacity(0.6),
                                          blurRadius: 8,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'LIVE',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                      fontFamily: 'Gotham XLight',
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.streamPlaying,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Gotham XLight',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Right side - Player controls
                      StreamBuilder<PlayerState>(
                        stream: _player.playerStateStream,
                        builder: (context, snapshot) {
                          final playerState = snapshot.data;
                          final processingState = playerState?.processingState;
                          final playing = playerState?.playing;
                          
                          if (processingState == ProcessingState.loading ||
                              processingState == ProcessingState.buffering) {
                            return Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(14.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              ),
                            );
                          }
                          
                          IconData iconData;
                          VoidCallback onPressed;
                          
                          if (playing != true) {
                            iconData = Icons.play_arrow_rounded;
                            onPressed = _player.play;
                          } else if (processingState != ProcessingState.completed) {
                            iconData = Icons.pause_rounded;
                            onPressed = _player.pause;
                          } else {
                            iconData = Icons.replay_rounded;
                            onPressed = () => _player.seek(Duration.zero);
                          }
                          
                          return Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.white, Color(0xFFF0F0F0)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: onPressed,
                                borderRadius: BorderRadius.circular(28),
                                child: Icon(
                                  iconData,
                                  color: const Color(0xff264796),
                                  size: 32,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactButton({
    required VoidCallback onPressed,
    required Widget icon,
  }) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Center(child: icon),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Lagos 92.3 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        var phoneNumber = '+234700923923923';
        launchUrl(Uri.parse('tel:$phoneNumber'));
        Navigator.of(context).pop();
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('Ibadan 100.5 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        var phoneNumber = '+23470010051005';
        launchUrl(Uri.parse('tel:$phoneNumber'));
        Navigator.of(context).pop();
      },
    );
    Widget optionThree = SimpleDialogOption(
      child: const Text('Uyo 105.9 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        var phoneNumber = '+2348182229105';
        launchUrl(Uri.parse('tel:$phoneNumber'));
        Navigator.of(context).pop();
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: const Color(0xff264796),
      title: const Text('Call Inspiration FM',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      children: <Widget>[optionOne, optionTwo, optionThree],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  _launchWhatSappLagos() async {
    final url = Uri.parse('https://wa.me/2348173136193');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatSappIbadan() async {
    final url = Uri.parse('https://wa.me/2348091921005');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatSappUyo() async {
    final url = Uri.parse('https://wa.me/2349060308705');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showAlertDialogWhatsapp(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Lagos 92.3 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        _launchWhatSappLagos();
        Navigator.of(context).pop();
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('Ibadan 100.5 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        _launchWhatSappIbadan();
        Navigator.of(context).pop();
      },
    );
    Widget optionThree = SimpleDialogOption(
      child: const Text('Uyo 105.9 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        _launchWhatSappUyo();
        Navigator.of(context).pop();
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: const Color(0xff264796),
      title: const Text('Chat with Inspiration FM',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      children: <Widget>[optionOne, optionTwo, optionThree],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Future<void> sendMailLagos() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['info@ifm923.com'],
      /*cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],*/
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> sendMailIbadan() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['info@ifm1005.com'],
      /*cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],*/
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<void> sendMailUyo() async {
    final Email email = Email(
      body: 'Email body',
      subject: 'Email subject',
      recipients: ['info@uyo.ifm1059.com'],
      /*cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],*/
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  showAlertDialogSendMail(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Lagos 92.3 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        sendMailLagos();
        Navigator.of(context).pop();
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text('Ibadan 100.5 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        sendMailIbadan();
        Navigator.of(context).pop();
      },
    );
    Widget optionThree = SimpleDialogOption(
      child: const Text('Uyo 105.9 FM Live Studio',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        sendMailUyo();
        Navigator.of(context).pop();
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: const Color(0xff264796),
      title: const Text('Send Email To Inspiration FM',
          style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      children: <Widget>[optionOne, optionTwo, optionThree],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
