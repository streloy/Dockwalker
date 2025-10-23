import 'package:flutter/material.dart';
import 'dart:core';
import 'package:dockwalker/utils/AppColors.dart';

class Myjobcard extends StatelessWidget {
  final String imageUrl;
  final String company;
  final String title;
  final String description;
  final String location;
  final String budget;
  final String createdDate;
  final String dadeline;

  const Myjobcard({
    super.key,
    required this.imageUrl,
    required this.company,
    required this.title,
    required this.description,
    required this.location,
    required this.budget,
    required this.createdDate,
    required this.dadeline,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network( imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text("Urgent", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith( fontWeight: FontWeight.bold ) ),
                    Text(company, style: Theme.of(context).textTheme.titleMedium?.copyWith( fontWeight: FontWeight.normal )),
                  ],
                ),
                const SizedBox(height: 8),

                /// 3️⃣ Description
                description.isNotEmpty ?
                Text( description, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyMedium?.copyWith( color: Colors.grey[700] ) ) :
                SizedBox(width: 0),

                SizedBox(height: 8),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: Colors.black, size: 14),
                            const SizedBox(width: 4),
                            Text(location, style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.attach_money, color: Colors.black, size: 14),
                            const SizedBox(width: 4),
                            Text(budget, style: TextStyle(color: Colors.black) ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container( width: double.infinity, height: 1, color: Colors.black12 ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, color: Colors.black54, size: 14 ),
                        const SizedBox(width: 4),
                        Text( "Dadeline: $dadeline", style: TextStyle(color: Colors.black54) ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people_outline, color: Colors.black54, size: 14 ),
                        const SizedBox(width: 4),
                        Text( "10 Applicants", style: TextStyle(color: Colors.black54) ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
