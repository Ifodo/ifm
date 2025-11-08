
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inspiration/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterQuiz extends StatefulWidget {
  const RegisterQuiz({super.key});

  @override
  _RegisterQuizState createState() => _RegisterQuizState();
}

class _RegisterQuizState extends State<RegisterQuiz> {
  var regStatus;
  var myStringList;
  var myStringLength;

  String? uploadProgress;

  final myControllerName = TextEditingController();
  final myControllerLocation = TextEditingController();
  final myControllerAge = TextEditingController();
  final myControllerEmail = TextEditingController();
  final myControllerPhoneNumber = TextEditingController();
  final myControllerPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  void uploadRegDetails() async {
    print(myControllerPassword.text);
    print(myControllerEmail.text);
    print(myControllerPhoneNumber.text);
    try {
      var response = await Dio().post(
          'http://backend.servoserver.com.ng:80/api/listener_register',
          data: {
            "email": myControllerEmail.text,
            "fullname": myControllerName.text,
            "location": myControllerLocation.text,
            "phone": myControllerPhoneNumber.text,
            "age": myControllerAge.text,
            "password": myControllerPassword.text
          },
          onSendProgress: (actualBytes, totalBytes){
            var percentage = actualBytes / totalBytes * 100;
            setState(() {
              uploadProgress = 'Uploading... ${percentage.floor()} %';
            });
          });
      _showScaffold(response.data['display']);
      print('File uploaded response from server: $response');
      setState(() {
        uploadProgress = '';
        myControllerEmail.text = '';
        myControllerName.text = '';
        myControllerLocation.text = '';
        myControllerPhoneNumber.text = '';
        myControllerAge.text = '';
        myControllerPassword.text = '';


      });
      var resData = response.data['data'];
      var userID = resData['_id'];
      var fullname = resData['fullname'];
      print('user id: $userID');
      print('user id: $fullname');
      final prefs = await SharedPreferences.getInstance();
      prefs.setStringList('ifmData1', ['$userID', '$fullname']);
      showAlertDialog(context);


      //_showSnackBarMsg(response.data['display']);
    } catch (e) {
      print('Exception $e');
    }
  }

  navigateToQuiz(context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage(
          pageIndx: 9,
          quizIndex: 0
        ))
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: const Text('Continue', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
      onPressed: () {

        setState(() {
          navigateToQuiz(context);

        });

      },
    );


    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      backgroundColor: const Color(0xff264796),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inspiration FM Quiz', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight')),
          Text('You have registered..', style: TextStyle(color: Colors.white, fontFamily: 'Gotham XLight', fontSize: 14)),
        ],
      ),
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
  @override
  void initState() {
    _getSharedPref();
    super.initState();
  }

  _getSharedPref() async{
    var prefs = await SharedPreferences.getInstance();
    myStringList = prefs.getStringList('ifmData1') ?? '';
    print('from prefss: ${myStringList[0]}');
    myStringLength = myStringList.length;
    print('reg1: $myStringLength');
    if(myStringLength == 2){
      navigateToQuiz(context);
    }
  }

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  //final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _showScaffold(String message) {
    scaffoldMessengerKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),

    ));
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: scaffoldMessengerKey,
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 15.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Register, To Participate', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Gotham XLight', color: Color(0xff264796))),
              const SizedBox(
                height: 15.0,
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.email_outlined),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Email",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight',),
                        //hintText: "full name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Email' : null,
                      controller: myControllerEmail,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      autofocus: true,
                        keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.input_outlined),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Password",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight',),
                        //hintText: "full name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Password' : null,
                      controller: myControllerPassword,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person_add),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Full Name",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight'),
                        //hintText: "full name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Full Name' : null,
                      controller: myControllerName,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.add_location),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Location",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Location' : null,
                      controller: myControllerLocation,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.phone_in_talk_outlined),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Phone Number",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight'),
                        //hintText: "full name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Phone Number' : null,
                      controller: myControllerPhoneNumber,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      autofocus: true,
                      //maxLines: 8,
                      keyboardType: TextInputType.number,
                      //textInputAction: TextInputAction.send,
                      //textAlign: TextAlign.right,
                      //obscureText: true, // for password text
                      autocorrect: true,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        //prefix: Icon(Icons.person_add),
                        //prefixText: "Name: ",
                        //prefixStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                        labelText: "Age",
                        labelStyle: const TextStyle(fontSize: 19.0, fontFamily: 'Gotham XLight'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (val) => val!.isEmpty ? 'Enter your Age' : null,
                      controller: myControllerAge,
                      onChanged: (value) {
                        if(value.isNotEmpty){
                          _formkey.currentState!.validate();
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: screenWidth,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          textStyle: WidgetStateProperty.all(const TextStyle(color: Colors.white)),
                          backgroundColor: WidgetStateProperty.all(const Color(0xff264796)),
                          elevation: WidgetStateProperty.all(10.0),
                          side: WidgetStateProperty.all(const BorderSide(color: Colors.black26)),
                          shape: WidgetStateProperty.all<OutlinedBorder>(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0),
                                ),
                              )),
                        ),
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            uploadRegDetails();
                          }
                        },
                        child: const Text('Register', style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),

              Text(uploadProgress ?? '')
            ],
          ),
        ),
      ),
    );
  }
}


