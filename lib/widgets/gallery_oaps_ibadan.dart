
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/models/oap_stations_model.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:inspiration/widgets/gallery_oap_details.dart';

class GalleryOAPIbadan extends StatefulWidget {
  const GalleryOAPIbadan({super.key});

  @override
  _GalleryOAPIbadanState createState() => _GalleryOAPIbadanState();
}

class _GalleryOAPIbadanState extends State<GalleryOAPIbadan> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var station = 'Ibadan';

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: FutureBuilder<List<WelcomeOAPs>>(
            future: getOAPs(station),
            builder: (context, snapshot) {
              print('sssssssss11: ${snapshot.data.toString()}');
              if (snapshot.hasData) {
                return GridView.builder(
                    itemCount: snapshot.data!.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      WelcomeOAPs myImgFile = snapshot.data![index];
                      print('DDDD: ${myImgFile.oapPicture}');
                      var imgUrl = 'http://backend.servoserver.com.ng:80/uploads/${myImgFile.oapPicture}';
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: const Color(0x40264796), width: 1.0),
                                image: DecorationImage(
                                  image: NetworkImage(imgUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0x99264796),
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(color: const Color(0x99264796), width: 1.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${myImgFile.oapPersonalityName}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: 'Gotham XLight'
                                          )),
                                    ),
                                  )
                              ),
                            ),

                        ),
                        onTap: () {
                          _viewProfile(myImgFile);
                          /*showDialog(
                            barrierDismissible: true,
                            context: context,
                            child: CupertinoAlertDialog(
                              title: Column(
                                children: <Widget>[
                                  Text("Traffic Radio 96.1 FM"),
                                  Icon(
                                    Icons.mic_outlined,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                              content: Text("${myImgFile.oapPersonalityName.toString()}"),
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      _viewProfile(myImgFile);
                                      //Navigator.of(context).pop();
                                    },
                                    child: Text("View Profile"))
                              ],
                            ),
                          );*/
                        },
                      );
                    });
                }
              return const Center(child: CupertinoActivityIndicator());
            },
          ),
        ),
      ],
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
