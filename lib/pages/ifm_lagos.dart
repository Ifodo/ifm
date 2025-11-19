
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/models/noa_model.dart';
import 'package:inspiration/models/noa_new_model.dart';
import 'package:inspiration/pages/home_page.dart';
import 'package:inspiration/pages/latest_news.dart';
import 'package:inspiration/pages/video_live_stream.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:loading_gifs/loading_gifs.dart';


class IFMLagos extends StatefulWidget {
  const IFMLagos({super.key});

  @override
  _IFMLagosState createState() => _IFMLagosState();
}

class _IFMLagosState extends State<IFMLagos> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var stationName = 'ifm923';
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: Column(
        children: [
          /*Center(
            child: Text('Lagos 92.3 FM',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff264796),
                    fontFamily: 'Gotham XLight')),
          ),*/
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xffb30622),
                ),
                width: screenWidth,
                height: screenHeight / 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FutureBuilder<NowOnAirResponse>(
                      future: getNowOnAirNew(stationName),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.nowOnAir != null) {
                          var imgUrl = snapshot.data!.nowOnAir!.image;
                          print('Loaded image: $imgUrl');

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 180,
                              width: 145,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: FadeInImage.assetNetwork(
                                  placeholder: cupertinoActivityIndicator,
                                  image: imgUrl,
                                  placeholderScale: 1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }
                        // Show logo for error or no data
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 180,
                            width: 145,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.asset(
                                'assets/logo_general_small.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: FutureBuilder<NowOnAirResponse>(
                        future: getNowOnAirNew(stationName),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.nowOnAir != null) {
                            var nowOnAir = snapshot.data!.nowOnAir!;
                            var durationStart = nowOnAir.duration.start;
                            var durationEnd = nowOnAir.duration.end;
                            var programName = nowOnAir.programName;
                            var presenterName = nowOnAir.oaps.isNotEmpty 
                                ? nowOnAir.oaps.join(', ') 
                                : 'IFM Presenter';
                            print('Now on Air Data: ${nowOnAir.image}');
                            return SizedBox(
                              width: screenWidth / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: Text('Lagos 92.3 FM',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xffffffff),
                                            fontSize: 10,
                                            fontFamily: 'Gotham XLight')),
                                  ),
                                  const Align(
                                    alignment: Alignment.topRight,
                                    child: Text('Now On Air',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: Color(0xffffffff),
                                            fontSize: 20,
                                            fontFamily: 'Gotham XLight')),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      programName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontSize: 17.0,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Gotham XLight',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'with $presenterName',
                                      style: const TextStyle(
                                          fontSize: 11.0,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Gotham XLight',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Duration: $durationStart - $durationEnd',
                                      style: const TextStyle(
                                          fontSize: 11.0,
                                          color: Color(0xffffffff),
                                          fontFamily: 'Gotham XLight'),
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }
                          // Show dummy content for error or no data
                          return SizedBox(
                            width: screenWidth / 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text('Lagos 92.3 FM',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xffffffff),
                                          fontSize: 10,
                                          fontFamily: 'Gotham XLight')),
                                ),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text('Now On Air',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xffffffff),
                                          fontSize: 20,
                                          fontFamily: 'Gotham XLight')),
                                ),
                                const SizedBox(height: 5.0),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Stay Tuned',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        color: Color(0xffffffff),
                                        fontFamily: 'Gotham XLight',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 5.0),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'with Inspiration FM',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xffffffff),
                                        fontFamily: 'Gotham XLight',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    'Duration: -- : --',
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        color: Color(0xffffffff),
                                        fontFamily: 'Gotham XLight'),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )),
          ),
          const SizedBox(height: 8.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff264796), Color(0xff2a166f)],
              ),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff264796).withOpacity(0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Up Next Info
                    Expanded(
                      child: FutureBuilder<NowOnAirResponse>(
                        future: getNowOnAirNew(stationName),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.upNext != null) {
                            var upNext = snapshot.data!.upNext!;
                            var nextProgramName = upNext.programName;
                            var nextStart = upNext.duration.start;
                            var nextEnd = upNext.duration.end;
                            
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.upcoming_rounded, size: 12, color: Colors.white),
                                          SizedBox(width: 4),
                                          Text(
                                            'UP NEXT',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Gotham XLight',
                                              letterSpacing: 1.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  nextProgramName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham XLight',
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    const Icon(Icons.schedule_rounded, size: 12, color: Colors.white70),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$nextStart - $nextEnd',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                        fontFamily: 'Gotham XLight',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else if (snapshot.data == null || snapshot.data!.upNext == null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    'UP NEXT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gotham XLight',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                const Text(
                                  'Not on Air',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham XLight',
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                const Text(
                                  'Duration: -- : --',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white70,
                                    fontFamily: 'Gotham XLight',
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox(
                            height: 40,
                            child: Center(
                              child: CupertinoActivityIndicator(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(width: 12.0),
                    
                    // Watch Live Button
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffb30622), Color(0xff8a0419)],
                        ),
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xffb30622).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => navigateToStream(context),
                          borderRadius: BorderRadius.circular(14.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.play_circle_filled_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  'Watch Live',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham XLight',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Latest News',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Color(0xff264796),
                    fontFamily: 'Gotham XLight',
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Expanded(
            child: Center(child: LatestNews()),
          )
        ],
      ),
    );
  }
}

navigateToStream(context) {
  stopAudioStream();
  Navigator.push(
      context,
      //MaterialPageRoute(builder: (context) => VideoLiveStream())
      MaterialPageRoute(builder: (context) => const VideoLiveStream()));
}

stopAudioStream() {
  HomePage().stopAudio();
}
