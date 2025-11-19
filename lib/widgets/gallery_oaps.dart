
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/models/oap_stations_model.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:inspiration/widgets/gallery_oap_details.dart';

class GalleryOAP extends StatefulWidget {
  const GalleryOAP({super.key});

  @override
  _GalleryOAPState createState() => _GalleryOAPState();
}

class _GalleryOAPState extends State<GalleryOAP> {
  // Get dummy OAP data
  List<WelcomeOAPs> _getDummyOAPs() {
    return [
      WelcomeOAPs(
        id: 'dummy1',
        oapFullName: 'Inspiration FM Presenter',
        oapPersonalityName: 'Morning Show Host',
        oapPicture: null,
        profile: 'Stay tuned for updates',
        businessLocation: 'Lagos',
      ),
      WelcomeOAPs(
        id: 'dummy2',
        oapFullName: 'Inspiration FM Presenter',
        oapPersonalityName: 'Afternoon Drive',
        oapPicture: null,
        profile: 'Stay tuned for updates',
        businessLocation: 'Lagos',
      ),
      WelcomeOAPs(
        id: 'dummy3',
        oapFullName: 'Inspiration FM Presenter',
        oapPersonalityName: 'Evening Host',
        oapPicture: null,
        profile: 'Stay tuned for updates',
        businessLocation: 'Lagos',
      ),
      WelcomeOAPs(
        id: 'dummy4',
        oapFullName: 'Inspiration FM Presenter',
        oapPersonalityName: 'Weekend Show',
        oapPicture: null,
        profile: 'Stay tuned for updates',
        businessLocation: 'Lagos',
      ),
    ];
  }

  // Build OAP card widget
  Widget _buildOAPCard(WelcomeOAPs oap, {bool isDummy = false}) {
    var imgUrl = oap.oapPicture != null 
        ? 'http://backend.servoserver.com.ng:80/uploads/${oap.oapPicture}'
        : null;
    
    return GestureDetector(
      onTap: isDummy ? null : () => _viewProfile(oap),
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
              imgUrl != null
                  ? Image.network(
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
                    )
                  : Container(
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
                        oap.oapPersonalityName ?? 'Unknown',
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
  }

  @override
  Widget build(BuildContext context) {
    var station = 'Lagos';

    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: FutureBuilder<List<WelcomeOAPs>>(
        future: getOAPs(station),
        builder: (context, snapshot) {
          // Error or empty state - show dummy data immediately
          final hasValidData = snapshot.hasData && 
                               snapshot.data != null && 
                               snapshot.data!.isNotEmpty;
          
          if (snapshot.hasError || 
              (snapshot.connectionState == ConnectionState.done && !hasValidData)) {
            final dummyOAPs = _getDummyOAPs();
            return GridView.builder(
              itemCount: dummyOAPs.length,
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (BuildContext context, int index) {
                return _buildOAPCard(dummyOAPs[index], isDummy: true);
              },
            );
          }
          
          // Loading state - show dummy data after 2 seconds
          if (snapshot.connectionState == ConnectionState.waiting) {
            return FutureBuilder<List<WelcomeOAPs>>(
              future: Future.delayed(const Duration(seconds: 2), () => <WelcomeOAPs>[]),
              builder: (context, timeoutSnapshot) {
                if (timeoutSnapshot.connectionState == ConnectionState.done) {
                  // After 2 seconds, show dummy data while still loading
                  final dummyOAPs = _getDummyOAPs();
                  return GridView.builder(
                    itemCount: dummyOAPs.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0,
                      mainAxisSpacing: 12.0,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return _buildOAPCard(dummyOAPs[index], isDummy: true);
                    },
                  );
                }
                // Show loading indicator for first 2 seconds
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
              },
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
              return _buildOAPCard(snapshot.data![index], isDummy: false);
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
