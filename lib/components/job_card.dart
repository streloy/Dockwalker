import 'package:flutter/material.dart';
import 'dart:core';

class JobCard extends StatelessWidget {
  final String imageUrl;
  final String company;
  final String title;
  final String description;
  final String location;
  final String budget;
  final String createdDate;
  final String dadeline;

  const JobCard({
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network( imageUrl, height: 40, width: 40, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16) ),
                          Text(company, style: TextStyle(fontStyle: FontStyle.normal) ),
                        ],
                      ),
                    )
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
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text(location, style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 16 ),
                        const SizedBox(width: 0),
                        Text(budget, style: Theme.of(context).textTheme.bodyMedium ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.people, size: 16 ),
                        const SizedBox(width: 0),
                        Text("10 Applicants", style: Theme.of(context).textTheme.bodyMedium ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                /// 5️⃣ Created Date + Participants
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14 ),
                        const SizedBox(width: 4),
                        Text( "Dadeline: $dadeline", style: Theme.of(context).textTheme.bodySmall ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14 ),
                        const SizedBox(width: 4),
                        Text( "Created: $createdDate", style: Theme.of(context).textTheme.bodySmall ),
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
