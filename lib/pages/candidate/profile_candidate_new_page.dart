import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/candidate/job_applied_list_page.dart';
import 'package:dockwalker/controllers/candidate/profile_candidate_controller.dart';
import 'package:dockwalker/pages/candidate/profile_update_page.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/components/candidate_certificate_card.dart';
import 'package:dockwalker/pages/candidate/profile_update_certification.dart';
import 'package:dockwalker/pages/candidate/profile_update_education.dart';
import 'package:dockwalker/pages/candidate/profile_update_experience.dart';
import 'package:dockwalker/pages/candidate/profile_update_language.dart';
import 'package:dockwalker/pages/candidate/profile_update_skill.dart';


class ProfileCandidateNewPage extends StatefulWidget {
  const ProfileCandidateNewPage({super.key});

  @override
  State<ProfileCandidateNewPage> createState() => _ProfileCandidateNewPageState();
}

class _ProfileCandidateNewPageState extends State<ProfileCandidateNewPage> {
  final List<String> skills = [];
  final ProfileCandidateController controller = Get.put(ProfileCandidateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> RefreshIndicator(
        child: controller.homeService.urlloading.value == true ?
          Center(child: CircularProgressIndicator()) :
          SingleChildScrollView (
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
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
                  controller.available.value == "Yes" ?
                  Text( "Available for work", style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold) ) :
                  Text( "Not available for work", style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.bold) ),
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
              Text("${controller.detail.value}", textAlign: TextAlign.center,),

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

              const SizedBox(height: 24),
              Row(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.file_copy, color: Colors.black87, size: 18,),
                  SizedBox(width: 4),
                  Expanded(child: Text("Certificate & Document", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  InkWell(
                    onTap: () async { final result = await Get.to(()=> ProfileUpdateCertification()); if(result == true) { controller.refreshData(); } },
                    child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  )
                ],
              ),
              SizedBox(height: 8),
              Container(
                height: 200,
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  itemCount: controller.certificates.length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    dynamic item = controller.certificates[index];
                    print(item);
                    return GestureDetector(
                      child: Container(
                        width: 250,
                        height: 200,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        margin: EdgeInsets.only(right: 16),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300, width: 0),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.file_copy, color: Colors.black87,),
                                InkWell(
                                  onTap: () { controller.deleteCertificate(int.parse(item['id'])); },
                                  child: Icon(Icons.close, color: AppColors.primary),
                                )
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(item['document_name'], style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold )),
                            Text(item['document_source']),
                            SizedBox(height: 4),
                            Text("Issued: ${item['document_issue_date']}"),
                            Text("Expired: ${item['document_expire_date']}"),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(32)),
                              child: Text(item['status'] ?? "Valid", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold) ),
                            )
                          ],
                        ),
                      ),
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
                  InkWell(
                    onTap: () async {
                      final result = await Get.to(()=> ProfileUpdateEducation());
                      if(result == true) { controller.refreshData(); }
                    },
                    child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  )
                ],
              ),

              SizedBox(height: 8),
              ...controller.educations.value.map((education) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${education['education_degree']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          InkWell(
                            onTap: () { controller.deleteEducation(int.parse(education['id'])); },
                            child: Icon(Icons.close, size: 16),
                          )
                        ]
                      ),
                      
                      Text("${education['education_institution']}"),
                      Text("Grade: ${education['education_grade']}/${education['education_grade_total']}"),
                      Text("Period: ${education['education_time_range']}"),
                      SizedBox(height: 12), // optional spacing
                    ],
                  ),
                );
              }).toList(),
              SizedBox(height: 16),

              Row(
                children: [
                  Icon(Icons.work_history, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  InkWell(
                    onTap: () async {
                      final result = await Get.to(()=> ProfileUpdateExperience());
                      if(result == true) { controller.refreshData(); }
                    },
                    child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  )
                ],
              ),
              SizedBox(height: 8),
              ...controller.experiences.value.map((experience) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${experience['experience_position']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            InkWell(
                              onTap: () { controller.deleteExperience(int.parse(experience['id'])); },
                              child: Icon(Icons.close, size: 16),
                            )
                          ]
                      ),

                      Text("${experience['experience_company']}"),
                      Text("${experience['experience_start']} - ${experience['current'] == "Yes" ? "Current" : experience['experience_end']} " ),
                      SizedBox(height: 8),
                      Text("Responsibility", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text("${experience['responsibility']}"),
                      SizedBox(height: 12), // optional spacing
                    ],
                  ),
                );
              }).toList(),

              // New Skills
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Skills", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  InkWell(
                    onTap: () async {
                      final result = await Get.to(()=> ProfileUpdateSkill());
                      if(result == true) { controller.refreshData(); }
                    },
                    child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  )
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: controller.cskills.value.map((skill) {
                    return Chip(
                      label: Text( "${skill['skill_name']}", style: TextStyle(color: AppColors.primary) ),
                      deleteIcon: Icon(Icons.close, color: AppColors.primary),
                      onDeleted: () {
                        controller.deleteSkill(int.parse(skill['id']));
                      },
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        side: BorderSide(color: AppColors.primary),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.language, color: Colors.black87, size: 18),
                  SizedBox(width: 4),
                  Expanded(child: Text("Language", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87))),
                  InkWell(
                    onTap: () async {
                      final result = await Get.to(()=> ProfileUpdateLanguage());
                      if(result == true) { controller.refreshData(); }
                    },
                    child: Text("Add", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  )
                ],
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: Column(
                  children: controller.languages.value.map((language) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Text( "${language['language_name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)) ),
                        Chip(
                          label: Text( "${language['language_level']}", style: TextStyle(color: language['language_level'] == 'Basic' ? Colors.red : language['language_level'] == 'Intermediate' ? Colors.orange : language['language_level'] == 'Proficient' ? Colors.green : Colors.green) ),
                          backgroundColor: language['language_level'] == 'Basic' ? Colors.red.shade100 : language['language_level'] == 'Intermediate' ? Colors.orange.shade100 : language['language_level'] == 'Proficient' ? Colors.green.shade100 : Colors.green.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                            side: BorderSide(color: language['language_level'] == 'Basic' ? Colors.red : language['language_level'] == 'Intermediate' ? Colors.orange : language['language_level'] == 'Proficient' ? Colors.green : Colors.green),
                          ),
                          padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
                        ),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: () {controller.deleteLanguage(int.parse(language['id'])); },
                          child: Icon(Icons.close, size: 16),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  controller.gotoCandidateLogout();
                },
                icon: const Icon(Icons.logout),
                label: const Text("Log Out"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
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
