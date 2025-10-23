import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/candidate/job_applied_list_page.dart';
import 'package:dockwalker/controllers/candidate/profile_candidate_controller.dart';
import 'package:dockwalker/pages/candidate/profile_update_page.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/components/candidate_certificate_card.dart';


class ProfileCandidateNewPage extends StatefulWidget {
  const ProfileCandidateNewPage({super.key});

  @override
  State<ProfileCandidateNewPage> createState() => _ProfileCandidateNewPageState();
}

class _ProfileCandidateNewPageState extends State<ProfileCandidateNewPage> {
  final List<String> skills = [
    "JavaScript (ES6+)",
    "React.js",
    "Node.js / Express.js",
    "Python (Django / Flask)",
    "Database Management (MySQL, PostgreSQL, MongoDB)",
    "RESTful API Development",
    "Git / GitHub / CI-CD",
    "UI/UX Design Principles",
    "Cloud Deployment (AWS / Firebase)",
    "Agile / Scrum Methodology",
  ];
  final ProfileCandidateController controller = Get.put(ProfileCandidateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile"),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primary,
      //   foregroundColor: Colors.white,
      // ),
      body: Obx(()=> RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: controller.homeService.urlloading.value == true ? Center(child: CircularProgressIndicator()) : Column(
            children: [
              SizedBox(height: 16),
              // Profile picture
              controller.photourl.value.isNotEmpty ?
              CircleAvatar( radius: 60, backgroundImage: NetworkImage(controller.photourl.value) ) :
              CircleAvatar( radius: 60, backgroundColor: Colors.grey.shade200, child: Icon( Icons.person, size: 60, color: Colors.grey ) ),
              const SizedBox(height: 16),

              // Name
              Text( controller.fullname.value, style: Theme.of(context).textTheme.headlineSmall?.copyWith( fontWeight: FontWeight.bold ) ),

              SizedBox(height: 4),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.black87, size: 16),
                  const SizedBox(width: 4),
                  Text( controller.address.value, style: TextStyle(color: Colors.black87, fontSize: 16) ),
                ],
              ),

              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.calendar_today_outlined, color: AppColors.primary, size: 16),
                  const SizedBox(width: 4),
                  Text( "Available for work", style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold) ),
                ],
              ),

              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email, color: Colors.black87, size: 14),
                  const SizedBox(width: 4),
                  Text( controller.email.value, style: TextStyle(color: Colors.black87, fontSize: 14) ),
                ],
              ),

              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.mobile_friendly_outlined, color: Colors.black87, size: 14),
                  const SizedBox(width: 4),
                  Text( controller.mobile.value, style: TextStyle(color: Colors.black87, fontSize: 14) ),
                ],
              ),

              SizedBox(height: 4),
              Text("Experienced Full Stack Developer with 8+ years of expertise in web development, GIS applications, and AI/ML integration. Proficient in JavaScript (Node.js, React, Angular), Python (Django, Flask), PHP (Laravel, CodeIgniter), and databases (MySQL, PostgreSQL, NoSQL).", textAlign: TextAlign.center,),

              SizedBox(height: 4),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Edit Profile"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primary, width: 1),
                    foregroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                  ),
                  onPressed: () { Get.to( () => ProfileUpdatePage(), transition: Transition.rightToLeft ); },
                ),
              ),


              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300, width: 1)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bar_chart, color: AppColors.primary,),
                        SizedBox(width: 8),
                        Expanded(child: Text("Profile Completeness", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary))),
                        Text("85%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primary))
                      ],
                    ),
                    SizedBox(height: 16),
                    LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(8),
                      value: .85,
                      backgroundColor: AppColors.accent,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16),
                    Text("Complete your profile to get more job.", textAlign: TextAlign.start, style: TextStyle(color: Colors.black))
                  ],
                ),
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to( () => JobAppliedListPage(), transition: Transition.rightToLeft );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(4) ),
                      ),
                      child: Text("Applied\n4", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () { },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text("Interviews\n0", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(()=> ProfileCandidateNewPage());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Offers\n1", textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.file_copy, color: Colors.black87, size: 18,),
                  SizedBox(width: 4),
                  Expanded(child: Text("Certificate & Document", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: controller.certificateList.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    dynamic item = controller.certificateList[index];
                    return GestureDetector(
                      child: CandidateCertificateCard(id: item['id'],
                          certificateName: item['certificateName'],
                          certificateCompany: item['certificateCompany'],
                          issueDate: item['issueDate'],
                          expireDate: item['expireDate'],
                          status: item['status']),
                    );
                  }
                ),
              ),
              SizedBox(height: 16),

              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.book_rounded, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Education", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))
                ],
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(controller.education.value, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.work_history, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))
                ],
              ),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: Text(controller.experience.value, style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.settings, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Skills & Expertise", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))
                ],
              ),
              SizedBox(height: 8),
              // SizedBox(
              //   width: double.infinity,
              //   child: Text(controller.skills.value ?? "", style: TextStyle(fontSize: 16)),
              // ),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: skills.map((item) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 1),
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                    ),
                    child: Text( item, style: const TextStyle( color: AppColors.primary, fontWeight: FontWeight.w500 ) ),
                  );
                }).toList(),
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.language, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Language", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded( child: Text("English", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)) ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: Colors.green.shade100
                        ),
                        child: Text("Native", style: TextStyle(fontSize: 14, color: Colors.green)),
                      )
                    ]
                  ),
                  SizedBox(height: 8),
                  Row(
                      children: [
                        Expanded( child: Text("Spanish", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)) ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: Colors.orange.shade100
                          ),
                          child: Text("Conversational", style: TextStyle(fontSize: 14, color: Colors.orange)),
                        )
                      ]
                  )
                ],
              ),

              const SizedBox(height: 24),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     Get.to( () => ProfileUpdatePage(), transition: Transition.rightToLeft );
              //   },
              //   icon: const Icon(Icons.edit),
              //   label: const Text("Update Information"),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: AppColors.primary,
              //     foregroundColor: AppColors.darkText,
              //     minimumSize: const Size(double.infinity, 50),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(4),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  controller.gotoCandidateLogout();
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),

              SizedBox(height: 50)
            ],
          ),
        ),
        onRefresh: controller.refreshData,
      ))
    );
  }


}
