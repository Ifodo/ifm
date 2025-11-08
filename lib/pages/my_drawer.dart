import 'package:flutter/material.dart';
import 'package:inspiration/pages/home_page.dart';
import 'package:inspiration/pages/video_live_stream.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {



  final Function? onTap;
  const MyDrawer({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff264796)
            /*gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.5, 0.9],
                colors: [Color(0xff3A4591), Color(0xff4E7CBA)])*/,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 67,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/logo_general_small.png'))),
                        )
                      ],
                    ),
                  ),
                ),
               Container(
                    child: Column(
                      children: [
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.radio_outlined, color: Colors.white),
                            title: const Text('Lagos 92.3 FM', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 0)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.radio_outlined, color: Colors.white),
                            title: const Text('Uyo 105.9 FM', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 1)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.chrome_reader_mode_outlined,
                                color: Colors.white),
                            title: const Text('News', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 2)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.chrome_reader_mode_outlined, color: Colors.white),
                            title:
                            const Text('The Word For Today', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 3)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.chrome_reader_mode_outlined, color: Colors.white),
                            title:
                            const Text('Podcast Lagos', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 4)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.people_outline_outlined, color: Colors.white),
                            title: const Text('On Air Personalities', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 5)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.event_outlined, color: Colors.white),
                            title: const Text('Events', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 6)),
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.question_answer, color: Colors.white),
                            title: const Text('Quiz', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 7)),
                        /*ListTile(
                            visualDensity: VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: Icon(Icons.phone_in_talk_outlined, color: Colors.white),
                            title: Text('Call Studio', style: TextStyle(color: Colors.white)),
                            onTap: () => {
                              //onTap(context, 8)
                              studioCall(context)
                            }
                        ),*/
                        ListTile(
                            visualDensity: const VisualDensity(horizontal: 0, vertical: -2.5),
                            leading: const Icon(Icons.contact_mail, color: Colors.white),
                            title: const Text('Contact', style: TextStyle(color: Colors.white)),
                            onTap: () => onTap!(context, 8)),
                        const SizedBox(height: 25.0),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text('Your #1 Family Radio Station',
                                  style: TextStyle(
                                    //fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'Gotham XLight'))),
                        ),
                        const SizedBox(height: 10.0),

                      ]
                    ),
                  ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

_launchWhatSappUrl() async {
  final url = Uri.parse('https://wa.me/2348173136193');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchFFaceBookUrl() async {
  //const url = "'fb://profile/163697217416897', 'https://www.facebook.com/lagostrafficradio961'";
  final url = Uri.parse('https://www.facebook.com/lagostrafficradio961');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

_launchTwitterUrl() async {
  final url = Uri.parse('https://twitter.com/lagostraffic961?lang=en');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchInstagramUrl() async {
  final url = Uri.parse('https://www.instagram.com/lagostraffic/?hl=en');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchYoutubeUrl() async {
  final url = Uri.parse('https://www.youtube.com/c/trafficradio961/videos');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchWebsite() async {
  final url = Uri.parse('https://www.trafficradio961.ng');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

navigateToStream(context) {
  Navigator.pop(context);
  stopAudioStream();
  Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => VideoLiveStream())
      MaterialPageRoute(builder: (context) => const VideoLiveStream())
  );
}
studioCall(context) {
  Navigator.pop(context);
  stopAudioStream();
  var phoneNumber = '+234700923923923';
  launchUrl(Uri.parse('tel:$phoneNumber'));
}

stopAudioStream() {
  HomePage().stopAudio();
}


