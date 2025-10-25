import 'package:flutter/material.dart';

class EmployerJobcard extends StatelessWidget {

  final dynamic job;

  const EmployerJobcard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network( job['logourl'], height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) { return Icon( Icons.maps_home_work, size: 40 ); } ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Row(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded( child: Text( job['title'], style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18 ), overflow: TextOverflow.ellipsis) ),
                    Wrap(
                      spacing: 4,
                      children: [
                        job['urgent'] == 'Yes' ?
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), color: Colors.red ),
                          child: Text("Urgent", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),),
                        ) : SizedBox(height: 0),
                        job['feature'] == 'Yes' ?
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), color: Colors.orange ),
                          child: Text("Feature", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),),
                        ) : SizedBox(height: 0)
                      ],
                    )
                  ],
                ),

                Text(job['company_name'], style: Theme.of(context).textTheme.titleMedium?.copyWith( fontWeight: FontWeight.normal )),

                SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), color: Colors.green.shade50, border: Border.all(color: Colors.green.shade100, width: 1) ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon( Icons.anchor_outlined, color: Colors.green, size: 12 ),
                            SizedBox(width: 2),
                            Text(job['location'], style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12),),
                          ],
                        )
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration( borderRadius: BorderRadius.circular(8), color: Colors.blue.shade50, border: Border.all(color: Colors.blue.shade100, width: 1) ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon( Icons.file_present, color: Colors.blue, size: 12 ),
                            SizedBox(width: 2),
                            Text(job['visa'], style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),),
                          ],
                        )
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Container( width: double.infinity, height: 1, color: Colors.black12 ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( "Experience", style: TextStyle(color: Colors.black54) ),
                    Text( job['experience'], style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold) ),
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
