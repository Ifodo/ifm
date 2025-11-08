import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:html/parser.dart';
import 'package:inspiration/pages/wft_article.dart';
import 'package:inspiration/services/webservices.dart';

class WFTMonday extends StatefulWidget {
  const WFTMonday({super.key});

  @override
  _WFTMondayState createState() => _WFTMondayState();
}

class _WFTMondayState extends State<WFTMonday> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth,
        height: screenHeight - 390,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: FutureBuilder<List>(
          future: fetchWpPostWFT(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 16.0),
                itemBuilder: (context, index) {
                  Map wpPost = snapshot.data![index];
                  final String title = parse(wpPost['title']['rendered'])
                      .documentElement!
                      .text;
                  final String timeAgo = GetTimeAgo.parse(DateTime.parse(wpPost['date']));
                  
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WFTArticle(
                                url: wpPost['link'],
                                title: wpPost['title']['rendered'],
                                date: wpPost['date'],
                                content: wpPost['content']['rendered']
                              )
                          )
                      );
                    },
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Icon Container
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff264796),
                                    Color(0xff2a166f),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff264796).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.menu_book_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            
                            // Content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Color(0xff2a166f),
                                      fontFamily: 'Gotham XLight',
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.schedule_rounded,
                                        size: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        timeAgo,
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.grey.shade600,
                                          fontFamily: 'Gotham XLight',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            // Arrow Icon
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xff264796).withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 14,
                                color: Color(0xff264796),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
      );
  }
}
