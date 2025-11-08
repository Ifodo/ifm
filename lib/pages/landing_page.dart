import 'package:flutter/material.dart';
import 'package:inspiration/pages/home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg3.png"), fit: BoxFit.cover)),
          child: Column(
            children: [
              SizedBox(height: screenHeight / 5.5),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Image.asset('assets/logo_small.png'),
              ),
              SizedBox(height: screenHeight / 5.5),

              SizedBox(
                width: screenWidth / 1.4,
                height: 45,
                child: ElevatedButton(
                  //shape: RoundedRectangleBorder(
                   //   borderRadius: BorderRadius.circular(12.0),
                   //   side: BorderSide(color: Colors.black26)
                  //),
                  //color: Color(0xff264796),
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
                  onPressed: _onPressedLagos,
                  child:
                  const Text('Lagos 92.3 FM', style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    fontFamily: 'Gotham XLight'
                  )),
                ),
              ),
              const SizedBox(height: 5.0),

              /* SizedBox(
                width: screenWidth / 1.4,
                height: 45,
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
                  onPressed: _onPressedIbadan,
                  child:
                  const Text('Ibadan 100.5 FM', style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Gotham XLight')),
                ),
              ), */
              const SizedBox(height: 5.0),

              SizedBox(
                width: screenWidth / 1.4,
                height: 45,
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
                  onPressed: _onPressedUyo,
                  child:
                  const Text('Uyo 105.9 FM', style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Gotham XLight')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedLagos() {
    print('going to lagos');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
              pageIndx: 0
            )
        )

    );
  }



  void _onPressedIbadan() {
    print('going to Ibadan');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                pageIndx: 1
            )
        )
    );
  }

  void _onPressedUyo() {
    print('going to Uyo');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(
                pageIndx: 1
            )
        )
    );
  }
}
