import 'package:inspiration/models/spreaker_show_model.dart';
import 'package:inspiration/pages/podcast_listen.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PodcastLagos extends StatefulWidget {
  const PodcastLagos({Key? key}) : super(key: key);

  @override
  _PodcastLagosState createState() => _PodcastLagosState();
}

class _PodcastLagosState extends State<PodcastLagos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 12.0),
              const Text('Podcast', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12.0),
              FutureBuilder<WelcomeSpreakerShow>(
                future: getShows(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    WelcomeSpreakerShow sh = snapshot.data;
                    return ListView.builder(
                      itemCount: sh.response?.items?.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                                  var mainData = sh.response?.items?[index];
                                  //Map wpPost = snapshot.data![index];
                                  var imageUrl = mainData?.imageOriginalUrl;
                                  var title = mainData?.title;
                                  var showID = mainData?.showId;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PodcastListen(
                                                showID: showID,
                                                imageUrl: imageUrl
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
                                          // Podcast Image
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
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                        decoration: BoxDecoration(
                                                          gradient: const LinearGradient(
                                                            colors: [Color(0xff264796), Color(0xff2a166f)],
                                                          ),
                                                          borderRadius: BorderRadius.circular(6),
                                                        ),
                                                        child: const Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(Icons.podcasts_rounded, size: 12, color: Colors.white),
                                                            SizedBox(width: 4),
                                                            Text(
                                                              'PODCAST',
                                                              style: TextStyle(
                                                                fontSize: 9,
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontFamily: 'Gotham XLight',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
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
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.play_circle_outline_rounded,
                                                            size: 16,
                                                            color: Colors.grey.shade600,
                                                          ),
                                                          const SizedBox(width: 4),
                                                          Text(
                                                            'Listen Now',
                                                            style: TextStyle(
                                                              fontSize: 11.0,
                                                              color: Colors.grey.shade600,
                                                              fontFamily: 'Gotham XLight',
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                        ],
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
    ),
  );
  }
   getNothing(){}
}
