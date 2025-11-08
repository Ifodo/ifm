import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:html/parser.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:share_plus/share_plus.dart';

class NewsArticle extends StatelessWidget {
  final String? title;
  final String? date;
  final String? content;
  final String? imageUrl;
  final String? url;

  const NewsArticle({
    Key? key,
    @required this.title,
    @required this.date,
    @required this.content,
    @required this.imageUrl,
    @required this.url
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff264796), Color(0xff2a166f)],
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: const Text(
          'News Article',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gotham XLight',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded, color: Colors.white, size: 22),
            onPressed: () {
              Share.share("Download Inspiration FM Mobile App \n\n$url");
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            Container(
              width: screenWidth,
              height: screenHeight * 0.35,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: FadeInImage.assetNetwork(
                width: screenWidth,
                placeholder: cupertinoActivityIndicator,
                image: imageUrl!,
                placeholderScale: 5,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xff264796).withOpacity(0.1),
                    child: const Center(
                      child: Icon(
                        Icons.newspaper_rounded,
                        color: Color(0xff264796),
                        size: 60,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Content Container
            Container(
              width: screenWidth,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff264796), Color(0xff2a166f)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff264796).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.schedule_rounded,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          GetTimeAgo.parse(DateTime.parse(date!)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Gotham XLight',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    parse(title.toString()).documentElement!.text,
                    style: const TextStyle(
                      color: Color(0xff2a166f),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham XLight',
                      height: 1.4,
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Divider
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xff264796), Color(0xff2a166f)],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Content
                  Text(
                    parse(content.toString()).documentElement!.text,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      height: 1.8,
                      color: Color(0xff2a166f),
                      fontSize: 16.0,
                      fontFamily: 'Gotham XLight',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Share Section
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Share.share("Download Inspiration FM Mobile App \n\n$url");
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xff264796).withOpacity(0.1),
                              const Color(0xff2a166f).withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xff264796).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xff264796), Color(0xff2a166f)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xff264796).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.share_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Share This Article',
                                    style: TextStyle(
                                      color: Color(0xff2a166f),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gotham XLight',
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Spread the news with others',
                                    style: TextStyle(
                                      color: Color(0xff264796),
                                      fontSize: 11,
                                      fontFamily: 'Gotham XLight',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Color(0xff264796),
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
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



