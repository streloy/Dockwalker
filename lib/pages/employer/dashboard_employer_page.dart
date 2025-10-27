import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/controllers/employer/dashboard_employer_controller.dart';
import 'package:dockwalker/components/employer_jobcard.dart';
import 'package:dockwalker/pages/employer/job_detail_page.dart';
import 'package:dockwalker/pages/employer/job_post_page.dart';


class DashboardEmployerPage extends StatefulWidget {
  const DashboardEmployerPage({super.key});

  @override
  State<DashboardEmployerPage> createState() => _DashboardEmployerPageState();
}

class _DashboardEmployerPageState extends State<DashboardEmployerPage> {

  final DashboardEmployerController controller = Get.put(DashboardEmployerController());

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.pageRefresh,
      child: Obx(() => controller.homeService.urlloading.value
          ? Center(child: CircularProgressIndicator())
          : ListView(
        // Always scrollable (important for pull-to-refresh)
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text(
              'Posted Jobs',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          if (controller.jobList.isEmpty)
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              color: Colors.grey.shade300,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("No jobs found!"),
                  const SizedBox(height: 8),
                  const Text(
                    "Start by posting your first job to find the perfect crew",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Post Your First Job"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () { Get.to(()=> JobPostPage(), transition: Transition.rightToLeft); },
                  ),
                ],
              ),
            )
          else
            ...controller.jobList.map((item) {
              return GestureDetector(
                child: EmployerJobcard(job: item),
                onTap: () {
                  Get.to(() => JobDetailPage(), arguments: {'jobid': item['id']}, transition: Transition.rightToLeft);
                },
              );
            }).toList(),
        ],
      )),
    );
  }
}
