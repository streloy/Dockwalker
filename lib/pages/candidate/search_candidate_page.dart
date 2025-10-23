import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/controllers/candidate/search_candidate_controller.dart';
import 'package:dockwalker/components/jobcard.dart';
import 'package:dockwalker/pages/candidate/job_detail_page.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';

class SearchCandidatePage extends StatefulWidget {
  const SearchCandidatePage({super.key});

  @override
  State<SearchCandidatePage> createState() => _SearchCandidatePageState();
}

class _SearchCandidatePageState extends State<SearchCandidatePage> {

  final SearchCandidateController _controller = Get.put(SearchCandidateController());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  bool showFilters = false;

  String selectedRole = "All";
  String selectedLocation = "All";
  String selectedSalary = "All";

  final roles = ["All", "Deck", "Interior", "Galley", "Engine"];
  final locations = ["All", "Mediterranean", "Caribbean", "USA"];
  final salaries = ["All", "< 3000", "3000–5000", "5000–8000"];

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
      child: Obx(()=> _controller.homeService.urlloading == true ?
      Center(child: CircularProgressIndicator()) : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Icon( CupertinoIcons.search, color: Colors.grey, size: 20, ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: 'Search positions or yachts...',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            onChanged: (String? value) {
                              _controller.searchText.value = value.toString();
                              _controller.filteredJobs;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: IconButton(
                    icon: Icon( CupertinoIcons.slider_horizontal_3, color: AppColors.secondary ),
                    onPressed: () { setState(() => showFilters = !showFilters); },
                  ),
                ),
              ],
            ),
          ),

          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: showFilters ? null : 0,
            child: showFilters ?
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildFilterGroup("Role", CupertinoIcons.briefcase, roles, selectedRole,
                          (val) => setState(() => selectedRole = val)),
                  const SizedBox(height: 10),
                  buildFilterGroup("Location", CupertinoIcons.location, locations, selectedLocation,
                          (val) => setState(() => selectedLocation = val)),
                  const SizedBox(height: 10),
                  buildFilterGroup("Salary", CupertinoIcons.money_dollar, salaries, selectedSalary,
                          (val) => setState(() => selectedSalary = val)),
                ],
              ),
            ) : null,
          ),

          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _controller.filteredJobs.length+1,
              itemBuilder: (BuildContext context, int index) {
                if(index >= _controller.filteredJobs.length) {
                  if(_controller.pageNumber.value < _controller.pageTotal.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return SizedBox(height: 16);
                  }
                } else {
                  dynamic item = _controller.filteredJobs[index];
                  return GestureDetector(
                    // child: Myjobcard(
                    //   imageUrl: item['logourl'] ?? "",
                    //   company: item['company_name'] ?? "",
                    //   title: item['title'] ?? "",
                    //   description: item['short_description'] ?? "",
                    //   location: item['location'] ?? "",
                    //   budget: item['salary'] ?? "",
                    //   createdDate: item['posted_on'] ?? "" ,
                    //   dadeline: item['deadline'] ?? "",
                    // ),
                    // onTap: () {
                    //   Get.to(
                    //         () => JobDetailPage(),
                    //     arguments: {'jobid': item['id']},
                    //     transition: Transition.rightToLeft,
                    //   );
                    // },
                    child: Jobcard(job: item),
                    onTap: () {
                      Get.to( () => JobDetailPage(),
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
      ))
    );
  }

  Widget buildFilterGroup( String title, IconData icon, List<String> options, String selected, Function(String) onSelect ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.black54),
            const SizedBox(width: 6),
            Text( title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15) ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((opt) {
            final isSelected = opt == selected;
            return GestureDetector(
              onTap: () => onSelect(opt),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.secondary : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text( opt, style: TextStyle( color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w500 ) ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

}
