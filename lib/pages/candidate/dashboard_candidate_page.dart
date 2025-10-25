import 'package:dockwalker/controllers/candidate/dashboard_candidate_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/components/jobcard.dart';
import 'package:dockwalker/pages/candidate/job_detail_page.dart';

class DashboardCandidatePage extends StatefulWidget {
  const DashboardCandidatePage({super.key});

  @override
  State<DashboardCandidatePage> createState() => _DashboardCandidatePageState();
}

class _DashboardCandidatePageState extends State<DashboardCandidatePage> {

  final DashboardCandidateController _controller = Get.put(DashboardCandidateController());
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        if(_controller.pageNumber.value < _controller.pageTotal.value) {
          _controller.fetchJobInfo();
        }
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _controller.refresh,
      child: Obx(()=> _controller.homeService.urlloading.value == true ?
          Center(child: CircularProgressIndicator()) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Text( 'Available Jobs', textAlign: TextAlign.start, style: Theme.of(context).textTheme.headlineSmall?.copyWith( fontWeight: FontWeight.bold, fontSize: 20 ) ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _controller.jobList.length+1,
              itemBuilder: (BuildContext context, int index) {
                if(index >= _controller.jobList.length) {
                  if(_controller.pageNumber.value < _controller.pageTotal.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(height: 16);
                  }
                } else {
                  dynamic item = _controller.jobList[index];
                  return GestureDetector(
                    child: Jobcard(job: item),
                    onTap: () {
                      Get.to(
                            () => JobDetailPage(),
                        arguments: {'jobid': item['id']},
                        transition: Transition.rightToLeft,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      )),
    );
  }


}
