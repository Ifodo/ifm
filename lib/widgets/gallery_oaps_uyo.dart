
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/models/oap_stations_model.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:inspiration/widgets/gallery_oap_details.dart';

class GalleryOAPUyo extends StatefulWidget {
  const GalleryOAPUyo({super.key});

  @override
  _GalleryOAPUyoState createState() => _GalleryOAPUyoState();
}

class _GalleryOAPUyoState extends State<GalleryOAPUyo> {
  @override
  Widget build(BuildContext context) {
    var station = 'Uyo';

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FutureBuilder<List<WelcomeOAPs>>(
        future: getOAPs(station),
        builder: (context, snapshot) {
          // Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CupertinoActivityIndicator(radius: 20),
                  const SizedBox(height: 16),
                  Text(
                    'Loading OAPs...',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Error state
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load OAPs',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please check your connection',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Empty state
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline_rounded,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No OAPs Available',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check back later',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                ],
              ),
            );
          }
          
          // Success state
          return GridView.builder(
            itemCount: snapshot.data!.length,
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (BuildContext context, int index) {
              WelcomeOAPs myImgFile = snapshot.data![index];
              var imgUrl = 'http://backend.servoserver.com.ng:80/uploads/${myImgFile.oapPicture}';
              
              return GestureDetector(
                onTap: () => _viewProfile(myImgFile),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff264796).withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Image with error handling
                        Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: const Color(0xff264796).withOpacity(0.1),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person_rounded,
                                    size: 48,
                                    color: Color(0xff264796),
                                  ),
                                ],
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: const Color(0xff264796).withOpacity(0.05),
                              child: const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            );
                          },
                        ),
                        
                        // Gradient overlay
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.85),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                child: Text(
                                  myImgFile.oapPersonalityName ?? 'Unknown',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gotham XLight',
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  _viewProfile(WelcomeOAPs myData){
    print('${myData.oapPersonalityName}');
    //Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GalleryOapDetails(
              image: myData.oapPicture,
              fullName: myData.oapFullName,
              personalityName: myData.oapPersonalityName,
              profile: myData.profile,
            )
        )
    );
  }
}
