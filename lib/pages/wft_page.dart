import 'package:flutter/material.dart';
import 'package:inspiration/widgets/constants.dart';
import 'package:inspiration/widgets/wft_monday.dart';

// ignore: must_be_immutable
class WFTPage extends StatelessWidget {
  DateTime date = DateTime.now();

  WFTPage({super.key});
  @override
  Widget build(BuildContext context) {
    print('date: ${date.weekday}');
    var dow = date.weekday;

    return DefaultTabController(
      length: 1,
      //initialIndex: dow,
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Column(
              children: [
                /*Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text('The Word For Today',
                      style: TextStyle(fontFamily: 'Gotham XLight',
                          color: Color(0xff264796),
                          fontWeight: FontWeight.bold)),
                ),*/
                Align(
                  alignment: Alignment.center,
                  child: TabBar(
                    labelColor: const Color(0xff264796),
                    unselectedLabelColor: kGrey1,
                    unselectedLabelStyle: kNonActiveTabStyle,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: const Color(0xff2a166f),
                    labelStyle: kActiveTabStyle.copyWith(fontSize: 18.0),
                    tabs: const [
                      Tab(child: Text('The Word For Today', style: TextStyle(fontFamily: 'Gotham XLight', fontWeight: FontWeight.w900)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              WFTMonday()

            ],
          ),
        ),
      ),
    );
  }
  }

