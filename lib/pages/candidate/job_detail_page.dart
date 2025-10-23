import 'package:flutter/material.dart';
import 'dart:core';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/controllers/candidate/job_detail_controller.dart';
import 'package:dockwalker/pages/candidate/message_candidate_page.dart';

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

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(CupertinoIcons.chat_bubble_2),
                            label: Text("Message"),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.blue, width: 1),
                              foregroundColor: Colors.blue,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            onPressed: () {
                              Get.to(()=> MessageCandidatePage(), arguments: { 'title': _controller.jobdata['company_name'], 'employer_id': _controller.jobdata['employer_id'], 'candidate_id': _controller.userid.value, 'sender_id': _controller.userid.value  }, transition: Transition.rightToLeft);
                            },
                          ),
                        ),
                        SizedBox(width: 16),

                        _controller.isapplied.value == 200 ?
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add_box),
                            label: Text("Apply This Job"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () { _controller.showApplyDialog(); },
                          ),
                        ) :
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add_box),
                            label: Text("Already Applied"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white38,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12) ),
                            ),
                            onPressed: null,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 50),
                    Text( "Company Information", textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold ) ),
                    SizedBox(height: 12),
                    // Row(
                    //   children: [
                    //     Image.network( _controller.jobdata['logourl'], height: 48, width: 48, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
                    //     SizedBox(width: 12),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text( _controller.jobdata['company_name'], textAlign: TextAlign.start, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold ) ),
                    //         Text( _controller.jobdata['address'], textAlign: TextAlign.start ),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    // SizedBox(height: 12),
                    // Text( "Email: ${_controller.jobdata['email']}", textAlign: TextAlign.start ),
                    // Text( "Mobile: ${_controller.jobdata['mobile']}", textAlign: TextAlign.start ),
                    // Text( "Website: ${_controller.jobdata['website']}", textAlign: TextAlign.start ),
                    // SizedBox(height: 50),


                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [ BoxShadow( color: Colors.black12, blurRadius: 6, offset: Offset(0, 3) ), ],
                      ),
                      child: Row(
                        children: [
                          ClipOval(child: Image.network( _controller.jobdata['logourl'], height: 48, width: 48, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } )),
                          SizedBox(width: 12),

                          // Name, company, and details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( _controller.jobdata['company_name'], style: TextStyle( fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87 ) ),
                                Text( _controller.jobdata['address'], style: TextStyle( color: Colors.grey[600], fontSize: 14) ),
                                SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon( CupertinoIcons.shield_fill, color: AppColors.secondary, size: 16 ),
                                    SizedBox(width: 4),
                                    Text( "Verified", style: TextStyle( color: AppColors.secondary, fontSize: 13) ),
                                    SizedBox(width: 12),
                                    Icon( CupertinoIcons.star_fill, color: AppColors.accent, size: 16 ),
                                    SizedBox(width: 4),
                                    Text( "5.0", style: TextStyle( color: Colors.black87, fontSize: 13 ) ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Icon( CupertinoIcons.right_chevron, color: Colors.grey ),
                        ],
                      ),
                    ),

                    SizedBox(height: 50),
                  ],
                )
            ),
          ],
        )),
      ),
    );
  }
}
