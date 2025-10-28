import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/controllers/employer/profile_employer_controller.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:dockwalker/services/home_service.dart';

class ProfileEmployerPage extends StatefulWidget {
  const ProfileEmployerPage({super.key});

  @override
  State<ProfileEmployerPage> createState() => _ProfileEmployerPageState();
}

class _ProfileEmployerPageState extends State<ProfileEmployerPage> {
  final HomeService homeService = Get.find<HomeService>();
  final ProfileEmployerController controller = Get.put(ProfileEmployerController());

  dynamic employer = {
    'logo': 'https://dockwalkerapp.com/assets/auth/8.jpg',
    'company_name': '',
    'email': '',
    'mobile': '',
    'address': '',
    'website': '',
    'description': '',
  };


  @override
  void initState() {
    super.initState();
    getEmployerInfo();
  }

  Future getEmployerInfo() async {
    dynamic a = await homeService.employerInfo();
    setState(() {
      employer = jsonDecode(a)['result'];
    });
  }

  Future<void> onRefresh() async {
    getEmployerInfo();
  }

  // ElevatedButton(onPressed: () { controller.gotoEmployerLogout(); }, child: Text("Logout"))

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: controller.homeService.urlloading.value == true ?
      Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            /// Employer Logo
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: (employer['logo'] != null && employer['logo'].isNotEmpty)
                  ? NetworkImage(employer['logo']!)
                  : const AssetImage('assets/logo.png') as ImageProvider,
              onBackgroundImageError: (_, __) {},
              child: employer['logo'] == null ? Image.asset('assets/logo.png', width: 48, height: 48) : null,
            ),

            const SizedBox(height: 12),
            Text(
              employer['company_name'] ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              employer['website'] ?? '',
              style: TextStyle(color: AppColors.secondary, fontSize: 14),
            ),

            const SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.grey.shade300),

            /// Info Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoRow(CupertinoIcons.mail_solid, 'Email', employer['email']),
                  _buildInfoRow(CupertinoIcons.phone_fill, 'Mobile', employer['mobile']),
                  _buildInfoRow(CupertinoIcons.location_solid, 'Address', employer['address']),
                  _buildInfoRow(CupertinoIcons.globe, 'Website', employer['website']),
                  const SizedBox(height: 12),

                  /// Description
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    height: 120,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      employer['description'] ?? '',
                      style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () { controller.gotoEmployerLogout(); },
                child: const Text('Logout'),
              ),
            ),
            // ElevatedButton(onPressed: () { controller.gotoEmployerLogout(); }, child: Text("Logout"))
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String? value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black54, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 13)),
                const SizedBox(height: 2),
                Text(value ?? '',
                    softWrap: true,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
    );
  }

}
