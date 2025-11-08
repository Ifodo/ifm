import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionControl extends StatefulWidget {
  final String? appUrl;
  const VersionControl({Key? key, this.appUrl}) : super(key: key);

  @override
  State<VersionControl> createState() => _VersionControlState();
}

class _VersionControlState extends State<VersionControl> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: const Color(0xffffffff),
              backgroundColor: const Color(0xffb30622), // foreground
            ),
            onPressed: () {
              print('APP URL : ${widget.appUrl}');
              var url = Uri.parse(widget.appUrl!);
              _launchInWebViewOrVC(url);
            },
            child: const Text('App Update Available',
                style: TextStyle(fontSize: 18)),
          )),
        ),
      ),
    );
  }
}

Future<void> _launchInWebViewOrVC(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(
        enableDomStorage: false,
    ),
  )) {
    throw Exception('Could not launch $url');
  }
}
