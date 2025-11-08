import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:inspiration/models/events_model.dart';
import 'package:inspiration/services/webservices.dart';
import 'package:loading_gifs/loading_gifs.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        /*child: RefreshIndicator(
          key: refreshKey,
          onRefresh: () {
            return Navigator.pushReplacementNamed(
                context,
                'routeName'
            );
          },*/
        child: FutureBuilder<WelcomeEvent>(
          future: getEvents(),
          builder: (context, snapshot) {
            print('sssssssssIII: ${snapshot.hasData}');
            print('sssaaaAS: ${snapshot.connectionState}');
            if (snapshot.hasData) {
              if(snapshot.data!.data!.isEmpty){
                print('Event has no data');
                return Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Container(
                    child: Column(
                      children: [
                        const Center(
                            child: Text('No Event Available',
                                style: TextStyle(
                                    fontFamily: 'Gotham XLight',
                                    color: Color(0xff264796),
                                    fontWeight: FontWeight.w900))),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          width: screenWidth / 1.3,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(const Color(0xff264796)),
                                elevation: WidgetStateProperty.all(10.0),
                                side: WidgetStateProperty.all(const BorderSide(color: Colors.black26)),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0),
                                      ),
                                    )),
                              ),
                            onPressed: () => {setReminder()},
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.alarm_add_outlined, color: Colors.white,),
                                SizedBox(width: 7.0),
                                Text('Set Reminder',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontFamily: 'Gotham XLight',
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.data!.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,

                itemBuilder: (context, index) {
                  var myData = snapshot.data!.data![index];
                  var myImgData = snapshot.data!.data![index].eventImage;
                  print('Loaded image data report: $myImgData');
                  var imgUrl = 'http://backend.servoserver.com.ng:80/uploads/$myImgData';
                  print('Loaded event: $myData');
                  //return Container();
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                              color: const Color(0xFFEAEAEA), width: 1.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              print('event clicked');
                              /*Navigator.push(
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
                              );*/
                            },
                            child: SizedBox(
                              height: 200,
                              width: screenWidth,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: FadeInImage.assetNetwork(
                                  height: 200,
                                  //width: screenWidth,
                                  placeholder: cupertinoActivityIndicator,
                                  image: imgUrl,
                                  placeholderScale: 5,
                                  fit: BoxFit.cover,
                                ),
                                //Image.asset(circularProgressIndicator, scale: 10),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                            child: Container(
                                child: Row(
                                  children: [
                                    const Text(
                                      'Event Name: ',
                                      overflow:
                                      TextOverflow.visible,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(
                                              0xff2a166f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      myData.eventName.toString(),
                                      overflow:
                                      TextOverflow.visible,
                                      maxLines: 4,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Color(
                                              0xff2a166f)),
                                    ),
                                  ],
                                )
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                            child: Container(
                                child: Row(
                                  children: [
                                    const Text(
                                      'Location: ',
                                      overflow:
                                      TextOverflow.visible,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(
                                              0xff2a166f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      myData.businessLocation.toString(),
                                      overflow:
                                      TextOverflow.visible,
                                      maxLines: 4,
                                      style: const TextStyle(
                                          fontSize: 14.0,
                                          color: Color(
                                              0xff2a166f)),
                                    ),
                                  ],
                                )
                            ),

                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                            child: Text(
                              'Venue: ',
                              overflow:
                              TextOverflow.visible,
                              maxLines: 4,
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color(
                                      0xff2a166f),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
                            child: Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        myData.venue.toString(),
                                        overflow:
                                        TextOverflow.visible,
                                        maxLines: 20,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            color: Color(
                                                0xff2a166f)),
                                      ),
                                    ),
                                  ],
                                )
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
                            child: Container(
                                child: Row(
                                  children: [
                                    const Text(
                                      'Date: ',
                                      overflow:
                                      TextOverflow.visible,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(
                                              0xff2a166f),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
                                      child: Text(
                                        myData.eventDateString.toString(),
                                        overflow:
                                        TextOverflow.visible,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ],
                                )
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
        //),
      ),
    );
  }
  showAlertSetReminder(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Lagos 92.3 FM Live Studio', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {
        //sendMailLagos();
        Navigator.of(context).pop();
      },
    );




    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: const Color(0xff264796),
      title: const Text('Send Email To Inspiration FM', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      children: <Widget>[
        optionOne
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Future<void> setReminder() async {
    final Email email = Email(
      body: 'Remind me when you have Events',
      subject: 'Event Reminder',
      recipients: ['info@ifm923.com'],
      /*cc: ['cc@example.com'],
      bcc: ['bcc@example.com'],*/
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}

 shwAlert() {
   AlertDialog(
     title: const Text('AlertDialog Title'),
     content: const SingleChildScrollView(
       child: ListBody(
         children: <Widget>[
           Text('This is a demo alert dialog.'),
           Text('Would you like to approve of this message?'),
         ],
       ),
     ),
     actions: <Widget>[
       TextButton(
         child: const Text('Approve'),
         onPressed: () {
           //Navigator.of(context).pop();
         },
       ),
     ],
   );
}
