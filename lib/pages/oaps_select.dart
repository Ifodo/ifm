import 'package:flutter/material.dart';
import 'package:inspiration/widgets/constants.dart';
import 'package:inspiration/widgets/gallery_oaps.dart';
import 'package:inspiration/widgets/gallery_oaps_uyo.dart';

class OAPsSelect extends StatelessWidget {
  const OAPsSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90.0),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8.0),
                const Text(
                  'On Air Personalities',
                  style: TextStyle(
                    fontFamily: 'Gotham XLight',
                    color: Color(0xff264796),
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 8.0),
                TabBar(
                  labelColor: const Color(0xff264796),
                  unselectedLabelColor: kGrey1,
                  unselectedLabelStyle: kNonActiveTabStyle,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xff2a166f),
                  labelStyle: kActiveTabStyle.copyWith(fontSize: 16.0),
                  tabs: const [
                    Tab(text: "Lagos"),
                    Tab(text: "Uyo")
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GalleryOAP(),
            GalleryOAPUyo()
          ],
        ),
      ),
    );
  }
}
