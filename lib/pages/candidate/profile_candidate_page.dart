import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/candidate/job_applied_list_page.dart';
import 'package:dockwalker/controllers/candidate/profile_candidate_controller.dart';
import 'package:dockwalker/pages/candidate/profile_update_page.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/pages/candidate/profile_candidate_new_page.dart';

class ProfileCandidatePage extends StatefulWidget {
  const ProfileCandidatePage({super.key});

  @override
  State<ProfileCandidatePage> createState() => _ProfileCandidatePageState();
}

class _ProfileCandidatePageState extends State<ProfileCandidatePage> {

  final Map<String, String> user = {
    "avatar": "https://www.rimes.int/sites/default/files/styles/people/public/staff_photos/Screen%20Shot%202022-10-07%20at%2008.33.24.png?itok=uo-UNEc9",
    "name": "Md Mobinur Rahman",
    "email": "mobinur@gmail.com",
    "role": "Candidate",
    "location": "Dhaka, Bangladesh",
  };

  final ProfileCandidateController controller = Get.put(ProfileCandidateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> RefreshIndicator(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 16),
              // Profile picture
              controller.photourl.value.isNotEmpty ?
              CircleAvatar( radius: 60, backgroundImage: NetworkImage(controller.photourl.value) ) :
              CircleAvatar( radius: 60, backgroundImage: NetworkImage(user["avatar"]!) ),
              const SizedBox(height: 16),

              // Name
              Text( controller.fullname.value, style: Theme.of(context).textTheme.headlineSmall?.copyWith( fontWeight: FontWeight.bold ) ),
              const SizedBox(height: 0),

              // Role & Email
              Text( controller.email.value, style: const TextStyle(fontSize: 14, color: Colors.grey), ),
              const SizedBox(height: 4),

              Text( controller.mobile.value, style: const TextStyle(fontSize: 14, color: Colors.grey), ),
              const SizedBox(height: 4),

              // Location
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text( controller.address.value, style: const TextStyle(color: Colors.grey) ),
                ],
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
                      child: const Text("Applied\n4", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Saved job");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Interviews\n0", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        print("Shared job");
                        Get.to(()=> ProfileCandidateNewPage());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Offers\n1", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Text("Education", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(controller.education.value),
              ),
              SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: Text("Experience", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(controller.experience.value),
              ),
              SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: Text("Skills", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(controller.skills.value),
              ),

              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Get.to( () => ProfileUpdatePage(), transition: Transition.rightToLeft );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Update Information"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: AppColors.darkText,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
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
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        onRefresh: controller.refreshData,
      ))
    );
  }

}
