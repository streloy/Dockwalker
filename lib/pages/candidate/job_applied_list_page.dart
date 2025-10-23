import 'package:flutter/material.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:get/get.dart';
import 'package:dockwalker/controllers/candidate/job_applied_list_controller.dart';

class JobAppliedListPage extends StatefulWidget {
  const JobAppliedListPage({super.key});

  @override
  State<JobAppliedListPage> createState() => _JobAppliedListPageState();
}

class _JobAppliedListPageState extends State<JobAppliedListPage> {

  final JobAppliedListController controller = Get.put(JobAppliedListController());

  final List<Map<String, dynamic>> appliedJobs = [
    {
      "jobTitle": "Captain",
      "company": "Motor Yacht",
      "location": "Chittagong",
      "status": "Pending"
    },
    {
      "jobTitle": "First Officer",
      "company": "Luxury Yacht",
      "location": "Dhaka",
      "status": "Reviewed"
    },
    {
      "jobTitle": "Engineer",
      "company": "Sea Explorer",
      "location": "Cox’s Bazar",
      "status": "Accepted"
    },
    {
      "jobTitle": "Deckhand",
      "company": "Blue Ocean",
      "location": "Sylhet",
      "status": "Rejected"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Applied Jobs"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: Obx(()=> ListView.builder(
        itemCount: controller.appliedJobs.length,
        itemBuilder: (context, index) {
          final job = controller.appliedJobs[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.network( "${job['logourl']}", height: 48, width: 48, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
              title: Text(job['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(job['company_name']),
                  Text("Expected: ${job['expected_salary']}"),
                  Text("Deadline: ${job['deadline']}"),
                  Text("Applied: ${job['created_at']}"),
                ],
              ),
              trailing: Chip(
                label: Text( job['status'], style: const TextStyle(color: Colors.white) ),
                backgroundColor: job['status'] == "Accepted" ? Colors.green
                    : job['status'] == "Rejected" ? Colors.red
                    : job['status'] == "Shortlist" ? Colors.orange
                    : job['status'] == "Pending" ? Colors.blue
                    : Colors.purple,
              ),
            ),
          );
        },
      )),
    );
  }
}
