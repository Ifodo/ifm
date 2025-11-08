import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:html/parser.dart';
import 'package:inspiration/pages/news_article.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:loading_gifs/loading_gifs.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: Container(
                width: screenWidth,
                height: 250.0,
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: const Color(0xFFEAEAEA), width: 1.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 168,
                      width: screenWidth,
                      color: Colors.transparent,
                      //child: NOAPicture(),
                      child: FutureBuilder<List>(
                        future: fetchWpPost(),
                        builder: (context, snapshot){
                          if(snapshot.hasData){
                            print('tttttss: $snapshot');
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index){
                                  Map wpPost = snapshot.data![index];
                                  var imageUrl = wpPost['_embedded']['wp:featuredmedia'][0]['source_url'];
                                  print('ttttttttt: $wpPost');
                                  return SizedBox(
                                    height: 168,
                                    width: screenWidth,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                      child: FadeInImage.assetNetwork(
                                        //height: 180,
                                        //width: screenWidth,
                                        placeholder: cupertinoActivityIndicator,
                                        image: imageUrl,
                                        placeholderScale: 1,
                                        fit: BoxFit.cover,
                                      ),
                                      //Image.asset(circularProgressIndicator, scale: 10),
                                    ),
                                  );
                                });
                          }
                          return const Center(child: CupertinoActivityIndicator());
                        },
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        height: 55,
                          child: FutureBuilder<List>(
                            future: fetchWpPost(),
                            builder: (context, snapshot){
                              if(snapshot.hasData){
                                return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    //shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index){
                                  Map wpPost = snapshot.data![index];
                                  return SizedBox(
                                    width: screenWidth,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          parse(wpPost['title']['rendered'])
                                              .documentElement!
                                              .text,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                              fontSize: 17.0,
                                              color: Color(0xff2a166f),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 3.0),
                                        Text(
                                          GetTimeAgo.parse(DateTime.parse(wpPost['date'])),
                                          style: const TextStyle(
                                            fontSize: 11.0,
                                            color: Color(0xffff0002),
                                          ),
                                        ),
                                        const SizedBox(height: 10.0)
                                      ],
                                    ),
                                  );
                                });

                              }
                              return const CupertinoActivityIndicator();
                            },
                          ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: screenWidth,
                height: screenHeight - 390,
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: FutureBuilder<List>(
                  future: fetchWpPost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16.0),
                itemBuilder: (context, index) {
                          Map wpPost = snapshot.data![index];
                          var imageUrl = wpPost['_embedded']['wp:featuredmedia'][0]['source_url'];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsArticle(
                                      url: wpPost['link'],
                                      title: wpPost['title']['rendered'],
                                      date: wpPost['date'],
                                      content: wpPost['content']['rendered'],
                                      imageUrl: wpPost['_embedded']
                                      ['wp:featuredmedia'][0]['source_url'] ?? '',
                                    )
                                  )
                              );
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
                                  // Image
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
                                        imageUrl ?? '',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            color: const Color(0xff264796).withOpacity(0.1),
                                            child: const Icon(
                                              Icons.newspaper_rounded,
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
                                            parse(wpPost['title']['rendered'])
                                                .documentElement!
                                                .text,
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
                                            children: [
                                              Icon(
                                                Icons.schedule_rounded,
                                                size: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                              const SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  GetTimeAgo.parse(DateTime.parse(wpPost['date'])),
                                                  style: TextStyle(
                                                      fontSize: 11.0,
                                                      color: Colors.grey.shade600,
                                                      fontFamily: 'Gotham XLight',
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                size: 14,
                                                color: const Color(0xff264796).withOpacity(0.5),
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
                    return const Center(child: CupertinoActivityIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}*/
