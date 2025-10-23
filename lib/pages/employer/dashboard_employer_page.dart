import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/controllers/employer/dashboard_employer_controller.dart';
import 'package:dockwalker/components/jobcard.dart';
import 'package:dockwalker/pages/candidate/job_detail_page.dart';

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
      child: Obx(()=> controller.homeService.urlloading.value == true ?
      Center(child: CircularProgressIndicator()) :
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text( 'Posted Jobs', textAlign: TextAlign.start, style: Theme.of(context).textTheme.headlineLarge?.copyWith( fontWeight: FontWeight.bold) ),
          ),
          SizedBox(height: 16),
          controller.jobList.length < 1 ?
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 0),
              color: Colors.grey.shade300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("No jobs found!"),
                  SizedBox(height: 0),
                  Text("Start by posting your first job to find the perfect crew"),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    label: Text("Post Your First Job"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () { },
                  )
                ],
              ),
            )
          ) :
          Expanded(
            child: ListView.builder(
              itemCount: controller.jobList.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic item = controller.jobList[index];
                return GestureDetector(
                  child: Jobcard(job: item),
                  onTap: () {
                    Get.to( () => JobDetailPage(), arguments: {'jobid': item['id']}, transition: Transition.rightToLeft, );
                  },
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
