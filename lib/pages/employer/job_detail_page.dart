import 'package:flutter/material.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/controllers/employer/job_detail_controller.dart';
import 'package:dockwalker/components/job_applied_candidate.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({super.key});

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {

  final JobDetailController _controller = Get.put(JobDetailController());
  final HomeService homeService = Get.find<HomeService>();
  dynamic params = Get.arguments;
  dynamic jobData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jobid.value = params['jobid'];
      _controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Detail"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Obx(()=>
        _controller.homeService.urlloading.value == true ? Container(margin: EdgeInsets.symmetric(vertical: 30), child: Center(child: CircularProgressIndicator())) :
        _controller.jobdata.isEmpty ? Container(margin: EdgeInsets.symmetric(vertical: 30), child: Center(child: CircularProgressIndicator())) :
        Column(
          children: [
            // Top banner image
            Image.network( _controller.jobdata['logourl'], height: 200, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4,
                      children: [
                        _controller.jobdata['urgent'] == "Yes" ?
                        Chip(
                          label: Text("Urgent", style: TextStyle(color: Colors.red) ),
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          backgroundColor: Colors.red.shade50,
                          side: BorderSide(width: .5, color: Colors.red.shade200),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
                        ) : SizedBox(width: 0),
                        _controller.jobdata['feature'] == "Yes" ?
                        Chip(
                          label: Text("Feature", style: TextStyle(color: Colors.orange) ),
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          backgroundColor: Colors.orange.shade50,
                          side: BorderSide(width: .5, color: Colors.orange.shade200),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
                        ) : SizedBox(width: 0),
                        Chip(
                          label: Text(_controller.jobdata['visa'], style: TextStyle(color: Colors.blue) ),
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          backgroundColor: Colors.blue.shade50,
                          side: BorderSide(width: .5, color: Colors.blue.shade200),
                          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8) ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(_controller.jobdata['title'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold) ),
                    Text(_controller.jobdata['company_name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
                    const SizedBox(height: 16),


                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: Colors.black, size: 14),
                            const SizedBox(width: 4),
                            Text(_controller.jobdata['location'], style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                        Row(
                          children: [
                            _controller.jobdata['currency_salary'] == "EUR" ?
                            const Icon(Icons.euro, color: Colors.black, size: 14):
                            _controller.jobdata['currency_salary'] == "GBP" ?
                            const Icon(Icons.currency_pound, color: Colors.black, size: 14):
                            const Icon(Icons.attach_money, color: Colors.black, size: 14),
                            const SizedBox(width: 4),
                            Text("${_controller.jobdata['min_salary']}-${_controller.jobdata['max_salary']}/${_controller.jobdata['period']}", style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_alarm, color: Colors.black, size: 14 ),
                            const SizedBox(width: 4),
                            Text( "Season: ${_controller.jobdata['duration']}", style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Colors.black, size: 14 ),
                            const SizedBox(width: 4),
                            Text( "Start: ${_controller.jobdata['start_date']}", style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    Row(
                      children: [
                        const Icon(Icons.people_rounded, size: 14, color: Colors.black),
                        const SizedBox(width: 4),
                        Expanded(child: Text("Vacancies: ${_controller.jobdata['vacancies']}"),)
                      ],
                    ),

                    const SizedBox(height: 16),
                    Text( "Description", textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold, fontSize: 18 ) ),
                    const SizedBox(height: 8),
                    Text("${_controller.jobdata['description']}"),
                    // Html(data: "${_controller.jobdata['description']}"),

                    const SizedBox(height: 16),
                    Text( "Requirements", textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold, fontSize: 18 ) ),
                    const SizedBox(height: 8),
                    Text("${_controller.jobdata['requirements']}"),

                    SizedBox(height: 32),
                    Text( "Applied Candidates", textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold, fontSize: 18 ) ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: _controller.jobacdata.length,
                        itemBuilder: (BuildContext context, int index) {
                          dynamic item = _controller.jobacdata[index];
                          return JobAppliedCandidate(job: item);
                        },
                      ),
                    )
                  ],
                )
            ),
          ],
        )),
      ),
    );
  }
}
