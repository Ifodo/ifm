import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff264796), Color(0xff2a166f)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.location_on_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'STUDIO LOCATIONS',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xff2a166f),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gotham XLight',
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Visit us at our studios',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontFamily: 'Gotham XLight',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                
                // Lagos Studio Card
                _buildStudioCard(
                  context: context,
                  title: 'Lagos Studio',
                  address: 'Amazing Grace Plaza:\nPlot 2E-4E Ligali Ayorinde St,\nVictoria Island, Lagos',
                  website: 'https://ifm923.com',
                  frequency: '92.3 FM',
                  onWebsiteTap: _launchWebsiteLagos,
                ),
                
                const SizedBox(height: 20.0),
                
                // Uyo Studio Card
                _buildStudioCard(
                  context: context,
                  title: 'Uyo Studio',
                  address: 'Olgerte house,\nUdo udoma Avenue,\nUyo, Akwa Ibom State',
                  website: 'https://ifm1059.com',
                  frequency: '105.9 FM',
                  onWebsiteTap: _launchWebsiteUyo,
                ),
                
                const SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudioCard({
    required BuildContext context,
    required String title,
    required String address,
    required String website,
    required String frequency,
    required VoidCallback onWebsiteTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Color(0xFFF8F9FF),
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff264796).withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: const Color(0xff264796).withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with frequency badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff2a166f),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xff264796), Color(0xff2a166f)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    frequency,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gotham XLight',
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16.0),
            
            // Address section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: const Color(0xff264796).withOpacity(0.1),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff264796).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: Color(0xff264796),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xff264796),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gotham XLight',
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          address,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontFamily: 'Gotham XLight',
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12.0),
            
            // Website button
            InkWell(
              onTap: onWebsiteTap,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff264796).withOpacity(0.05),
                      const Color(0xff2a166f).withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: const Color(0xff264796).withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xff264796), Color(0xff2a166f)],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.language_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Visit Website',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xff264796),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gotham XLight',
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            website,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xff2a166f),
                              fontFamily: 'Gotham XLight',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xff264796),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_launchWebsiteLagos() async {
  final url = Uri.parse('https://ifm923.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchWebsiteUyo() async {
  final url = Uri.parse('https://ifm1059.com');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}