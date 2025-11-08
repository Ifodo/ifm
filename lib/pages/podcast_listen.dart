import 'package:inspiration/models/spreaker_episodes_model.dart';
import 'package:inspiration/pages/podcast_player.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PodcastListen extends StatefulWidget {
  final int? showID;
  final String? imageUrl;
  const PodcastListen({Key? key, this.showID, this.imageUrl}) : super(key: key);

  @override
  _PodcastListenState createState() => _PodcastListenState();
}

class _PodcastListenState extends State<PodcastListen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Text('Podcast Listen', style: TextStyle(
                      color: Color(0xff2a166f))
                  )
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 12.0),
            // Banner Image
            FutureBuilder<WelcomeSpreakerEpisode>(
              future: getEpisodes(widget.showID),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  WelcomeSpreakerEpisode ep = snapshot.data;
                  if (ep.response?.items?.isNotEmpty ?? false) {
                    var imgUrl = ep.response?.items?[0].imageOriginalUrl;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff264796).withOpacity(0.15),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: FadeInImage.assetNetwork(
                            placeholder: cupertinoActivityIndicator,
                            image: imgUrl!,
                            placeholderScale: 1,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 20.0),
            // Episodes List
            FutureBuilder<WelcomeSpreakerEpisode>(
              future: getEpisodes(widget.showID),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  WelcomeSpreakerEpisode epp = snapshot.data;
                  return ListView.builder(
                    itemCount: epp.response?.items?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                                    var mainData = epp.response?.items?[index];
                                    //Map wpPost = snapshot.data![index];
                                    var imageUrl = mainData?.imageOriginalUrl;
                                    var title = mainData?.title;
                                    var showID = mainData?.showId;
                                    var dt = mainData?.publishedAt;
                                    var mediaFile = mainData?.playbackUrl;
                                    var episodeID = mainData?.episodeId;



                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          print('EPPP: $episodeID');
                                          //showAlertDialogPlayer(context, episodeID);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => PodcastPlayer(
                                                      showID: showID,
                                                      imageUrl: imageUrl,
                                                      episodeID: episodeID
                                                  )));
                                        });

                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Color(0xFFF8F9FF),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.circular(16.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xff264796).withOpacity(0.08),
                                              blurRadius: 12,
                                              offset: const Offset(0, 4),
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          border: Border.all(
                                            color: const Color(0xff264796).withOpacity(0.1),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Episode Image
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(16.0),
                                                  bottomLeft: Radius.circular(16.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    blurRadius: 8,
                                                    offset: const Offset(2, 0),
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(16.0),
                                                  bottomLeft: Radius.circular(16.0),
                                                ),
                                                child: Image.network(
                                                  imageUrl!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: const Color(0xff264796).withOpacity(0.1),
                                                      child: const Icon(
                                                        Icons.podcasts_rounded,
                                                        color: Color(0xff264796),
                                                        size: 32,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            
                                            // Content
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      title!,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          fontSize: 13.0,
                                                          color: Color(0xff2a166f),
                                                          fontFamily: 'Gotham XLight',
                                                          fontWeight: FontWeight.bold,
                                                          height: 1.4,
                                                          letterSpacing: -0.2,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.schedule_rounded,
                                                                size: 14,
                                                                color: Colors.grey.shade600,
                                                              ),
                                                              const SizedBox(width: 4),
                                                              Expanded(
                                                                child: Text(
                                                                  dt.toString(),
                                                                  overflow: TextOverflow.ellipsis,
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    fontSize: 10.0,
                                                                    color: Colors.grey.shade600,
                                                                    fontFamily: 'Gotham XLight',
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        Icon(
                                                          Icons.play_circle_fill_rounded,
                                                          size: 32,
                                                          color: const Color(0xff264796),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                    );
                  },
                );
              }
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CupertinoActivityIndicator(),
                ),
              );
            },
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    ),
  );
  }

  showAlertDialogPlayer(BuildContext context, episodeID) {
    // Create WebView controller
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(
          '<html><body><iframe src="https://widget.spreaker.com/player?episode_id=$episodeID" width="100%" height="200px" frameborder="0"></iframe></body></html>');
    
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: Column(
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: WebViewWidget(controller: controller),
            ),
          ),
        ],
      ),
      onPressed: () {
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
      children: <Widget>[optionOne],
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
