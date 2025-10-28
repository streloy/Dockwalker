import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/pages/employer/message_employer_page.dart';
import 'package:url_launcher/url_launcher.dart';

class CandidateDetailPage extends StatefulWidget {
  const CandidateDetailPage({super.key});

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {

  final List<Map<String, String>> certifications = [
    {
      "title": "STCW Basic Safety Training",
      "issuer": "MCA",
      "issued": "Jan 15, 2023",
      "expires": "Jan 15, 2028",
      "status": "Valid",
    },
    {
      "title": "Advanced Fire Fighting",
      "issuer": "IMO",
      "issued": "Feb 10, 2022",
      "expires": "Feb 10, 2027",
      "status": "Valid",
    },
    {
      "title": "Crowd Management",
      "issuer": "MCA",
      "issued": "Mar 01, 2021",
      "expires": "Mar 01, 2026",
      "status": "Expired",
    },
  ];

  dynamic params = Get.arguments;
  var candidateId = "";
  var candidateInfo = {};
  List<String> skills = [];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      setState(() {
        candidateId = params['candidate_id'];
        candidateInfo = params['candidate'];
        skills = List<String>.from(candidateInfo['skills_new'] ?? []);
      });
    });
  }

  Future<void> sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': "Email Subject",
        'body': "",
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(
        emailUri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No email app found on this device.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Candidate Details'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// --- Profile Header ---
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  ClipOval(
                    child: candidateInfo['photo'] != null && candidateInfo['photo'].toString().isNotEmpty ?
                    Image.network( candidateInfo['photo'], width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Image.asset( 'assets/logo.png', width: 100, height: 100, fit: BoxFit.cover, ); } ) :
                    Image.asset( 'assets/logo.png', width: 100, height: 100, fit: BoxFit.cover )
                  ),
                  const SizedBox(height: 12),
                  Text(
                    candidateInfo['fullname'] ?? "",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(candidateInfo['email'] ?? "", style: TextStyle(color: Colors.black54)),
                  Text(candidateInfo['mobile'] ?? "", style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.location_solid, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text(candidateInfo['address'] ?? "", style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.star, color: Colors.amber, size: 18),
                      SizedBox(width: 4),
                      Text('4.9', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Text('(18 reviews)', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '95% Match Score',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ],
              )
            ),

            Container( height: 16, color: Colors.grey.shade300 ),

            /// --- Application Info ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('New Application', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: const [
                      Icon(CupertinoIcons.briefcase, size: 18, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('Applied for: Chief Stewardess'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(CupertinoIcons.calendar, size: 18, color: Colors.black54),
                      SizedBox(width: 8),
                      Text('Applied on: January 16, 2024'),
                    ],
                  ),
                ],
              ),
            ),

            Container( height: 16, color: Colors.grey.shade300 ),

            /// --- Experience & Rating ---
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Column(
                    children: [
                      Text('6', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text('Years Exp.', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('4.9', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Text('Rating', style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                ],
              )
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( 'Certifications & Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
              ),
            ),
            const SizedBox(height: 12),

            /// --- Certifications Section ---
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: certifications.length,
                itemBuilder: (context, index) {
                  dynamic cert = certifications[index];

                  return Container(
                    width: 250,
                    margin: EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(CupertinoIcons.doc_text_fill, color: Colors.black54),
                            SizedBox(width: 8),
                            Expanded(child: Text( cert['title'], overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15) ) ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(cert['issuer'], style: TextStyle(color: Colors.black54)),
                        SizedBox(height: 8),
                        Text("Issued: ${cert['issued']}"),
                        Text("Expires: ${cert['expires']}"),
                        SizedBox(height: 6),
                      ],
                    ),
                  );
                }
              )
            ),

            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 24),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( 'Experience', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( candidateInfo['experience'] ?? "" ),
              ),
            ),

            const SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( 'Education', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( candidateInfo['education'] ?? "" ),
              ),
            ),



            /// --- Skills Section ---
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text( 'Skills & Expertise', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: skills.map((skill) => skillChip(skill)).toList(),
            ),

            SizedBox(height: 32),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(CupertinoIcons.envelope),
                      label: Text("Email"),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColors.primary, width: 1),
                        foregroundColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12) ),
                      ),
                      onPressed: () {
                        print(candidateInfo['email']);
                        sendEmail(candidateInfo['email']);
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(CupertinoIcons.chat_bubble_2),
                      label: Text("Message"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Get.to(()=> MessageEmployerPage(), arguments: { 'title': candidateInfo["fullname"], 'candidate_id': candidateInfo['user_id'] }, transition: Transition.rightToLeft);
                      },
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  static Widget skillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500)),
    );
  }
}
