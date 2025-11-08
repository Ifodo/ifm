import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:html/parser.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class WFTArticle extends StatelessWidget {
  final String? title;
  final String? date;
  final String? content;
  final String? url;

  const WFTArticle({
    Key? key,
    @required this.title,
    @required this.date,
    @required this.content,
    @required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff2a166f)),
            onPressed: (){
              Navigator.pop(context, false);
            },),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 60),
                child: Center(
                    child: Text('Word For Today Article', style: TextStyle(
                        color: Color(0xff2a166f), fontFamily: 'Gotham XLight', fontWeight: FontWeight.bold)
                    )
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: [
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                child: Text(
                  parse(title.toString())
                      .documentElement!
                      .text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Color(0xff2a166f),
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              /*Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: FadeInImage.assetNetwork(
                      height: 180.0,
                      width: screenWidth,
                      placeholder: cupertinoActivityIndicator,
                      image: imageUrl,
                      placeholderScale: 5,
                      fit: BoxFit.cover,
                    ),
                    //Image.asset(circularProgressIndicator, scale: 10),

                  ),

                ),
              ),*/
              Padding(
                padding: const EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                child: Text(
                  parse(title.toString())
                      .documentElement!
                      .text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff2a166f),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: SizedBox(
                  height: screenHeight * 0.60,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: Text(
                            parse(content.toString())
                                .documentElement!
                                .text,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                height: 1.8,
                                color: Color(0xff2a166f),
                                fontSize: 17.0,
                                fontFamily: 'Gotham XLight',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      GetTimeAgo.parse(DateTime.parse(date!)),
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Gotham XLight'
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: (){
                    _launchWebsite();
                  },
                  child: const Text(
                      'DONATE',
                      style: TextStyle(
                          color: Color(0xff2a166f),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                      ))
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Share.share("Download Inspiration FM Mobile App \n\n$url");
          },
          backgroundColor: const Color(0xff2a166f),
          child: const Icon(Icons.share_outlined),
        ),
      ),
    );
  }
  /*_shareContent(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    await Share.share('Text',
        subject: 'subject',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);

  }*/
}
_launchWebsite() async {
  final url = Uri.parse('http://gsafng.org/donate/');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}



