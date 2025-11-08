import 'package:inspiration/models/spreaker_episodes_model.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PodcastPlayer extends StatefulWidget {
  final int? showID;
  final String? imageUrl;
  final int? episodeID;
  const PodcastPlayer({
    Key? key,
    this.showID,
    this.imageUrl,
    this.episodeID
  }) : super(key: key);

  @override
  _PodcastPlayerState createState() => _PodcastPlayerState();
}

class _PodcastPlayerState extends State<PodcastPlayer> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(
          '<html><body><iframe src="https://widget.spreaker.com/player?episode_id=${widget.episodeID}" width="100%" height="200px" frameborder="0"></iframe></body></html>');
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: Text('Podcast Player', style: TextStyle(
                      color: Color(0xff2a166f))
                  )
              ),
            ),
          ],
        ),
      ),
        body: Column(
          children: [
            const SizedBox(height: 20.0),
            SizedBox(
              height: 220,
              width: screenWidth,
              //child: NOAPicture(),
              child: FutureBuilder<WelcomeSpreakerEpisode>(
                future: getEpisodes(widget.showID),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    WelcomeSpreakerEpisode ep = snapshot.data;
                    print('tttttss: ${snapshot.data}');
                    print('SpP: ${ep.response?.items}');
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ep.response?.items?.length,
                        itemBuilder: (context, index) {
                          var mainData = ep.response?.items?[index];
                          var imgUrl = mainData?.imageOriginalUrl;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 220,
                              width: screenWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: FadeInImage.assetNetwork(
                                  //height: 180,
                                  //width: screenWidth,
                                  placeholder: cupertinoActivityIndicator,
                                  image: imgUrl!,
                                  placeholderScale: 1,
                                  fit: BoxFit.cover,
                                ),
                                //Image.asset(circularProgressIndicator, scale: 10),
                              ),
                            ),
                          );
                        });
                  }
                  return const Center(child: CupertinoActivityIndicator());
                },
              ),
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: screenWidth,
              height: screenHeight / 2,
              child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: WebViewWidget(controller: _controller),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
