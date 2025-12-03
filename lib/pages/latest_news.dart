import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:html/parser.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:inspiration/pages/news_article.dart';

class LatestNews extends StatelessWidget {
  const LatestNews({super.key});

  // Helper method to build news card
  Widget _buildNewsCard(BuildContext context, double screenWidth, {
    required String title,
    required String date,
    String? imageUrl,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth / 2.5,
        height: 220,
        margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF8F9FF),
            ],
          ),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff264796).withOpacity(0.12),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: const Color(0xff264796).withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with overlay
            Stack(
              children: [
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: imageUrl != null && imageUrl.isNotEmpty
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xff264796).withOpacity(0.1),
                                child: const Center(
                                  child: Icon(
                                    Icons.newspaper_rounded,
                                    color: Color(0xff264796),
                                    size: 32,
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(
                            color: const Color(0xff264796).withOpacity(0.1),
                            child: const Center(
                              child: Icon(
                                Icons.newspaper_rounded,
                                color: Color(0xff264796),
                                size: 32,
                              ),
                            ),
                          ),
                  ),
                ),
                // Gradient overlay at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Color(0xff2a166f),
                          fontFamily: 'Gotham XLight',
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule_rounded,
                          size: 10,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Text(
                            date,
                            style: TextStyle(
                              fontSize: 9.0,
                              color: Colors.grey.shade600,
                              fontFamily: 'Gotham XLight',
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
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
  }

  // Get dummy news data
  List<Map<String, dynamic>> _getDummyNews() {
    final now = DateTime.now();
    return [
      {
        'title': 'Stay Tuned for Latest Updates',
        'date': GetTimeAgo.parse(now.subtract(const Duration(hours: 2))),
        'imageUrl': null,
      },
      {
        'title': 'Inspiration FM Bringing You the Best',
        'date': GetTimeAgo.parse(now.subtract(const Duration(hours: 5))),
        'imageUrl': null,
      },
      {
        'title': 'Check Back Soon for More News',
        'date': GetTimeAgo.parse(now.subtract(const Duration(days: 1))),
        'imageUrl': null,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight / 3.2,
      padding: const EdgeInsets.only(left: 1.0, right: 1.0),
      child: FutureBuilder<List>(
        future: fetchWpPost(),
        builder: (context, snapshot) {
          // Handle error or empty data
          if (snapshot.hasError || 
              (snapshot.hasData && (snapshot.data == null || snapshot.data!.isEmpty))) {
            // Show dummy content
            final dummyNews = _getDummyNews();
            return ListView.builder(
              itemCount: dummyNews.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              itemBuilder: (context, index) {
                final news = dummyNews[index];
                return _buildNewsCard(
                  context,
                  screenWidth,
                  title: news['title'],
                  date: news['date'],
                  imageUrl: news['imageUrl'],
                  onTap: null, // Dummy content is not clickable
                );
              },
            );
          }
          
          // Handle successful data
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              itemBuilder: (context, index) {
                try {
                  Map wpPost = snapshot.data![index];
                  var imageUrl = wpPost['_embedded']?['wp:featuredmedia']?[0]?['source_url'];
                  var title = parse(wpPost['title']['rendered']).documentElement!.text;
                  var date = GetTimeAgo.parse(DateTime.parse(wpPost['date']));
                  
                  return _buildNewsCard(
                    context,
                    screenWidth,
                    title: title,
                    date: date,
                    imageUrl: imageUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsArticle(
                            url: wpPost['link'],
                            title: wpPost['title']['rendered'],
                            date: wpPost['date'],
                            content: wpPost['content']['rendered'],
                            imageUrl: imageUrl ?? '',
                          ),
                        ),
                      );
                    },
                  );
                } catch (e) {
                  // If there's an error parsing individual item, show dummy
                  final dummyNews = _getDummyNews();
                  if (index < dummyNews.length) {
                    final news = dummyNews[index];
                    return _buildNewsCard(
                      context,
                      screenWidth,
                      title: news['title'],
                      date: news['date'],
                      imageUrl: news['imageUrl'],
                      onTap: null,
                    );
                  }
                  return const SizedBox.shrink();
                }
              },
            );
          }
          
          // Loading state
          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}

gotoNewsDetails(context) {
  //Navigator.push(context, MaterialPageRoute(builder: (context) => NewsArticle()));
}
