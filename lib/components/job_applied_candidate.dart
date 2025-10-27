import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/employer/message_employer_page.dart';

class JobAppliedCandidate extends StatelessWidget {
  final dynamic job;
  const JobAppliedCandidate({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 8),
      elevation: 1, // shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(job['photo']),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text( job['fullname'], style: TextStyle(fontWeight: FontWeight.bold) ),
        subtitle: Text(job['expected_salary']),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          print(job);
          Get.to(()=> MessageEmployerPage(), arguments: { 'title': job["fullname"], 'candidate_id': job['candidate_id'] }, transition: Transition.rightToLeft);
        },
      ),
    );
  }
}
