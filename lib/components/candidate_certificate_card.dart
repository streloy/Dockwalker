import 'package:flutter/material.dart';
import 'package:dockwalker/utils/AppColors.dart';

class CandidateCertificateCard extends StatelessWidget {

  final String id;
  final String certificateName;
  final String certificateCompany;
  final String issueDate;
  final String expireDate;
  final String status;

  const CandidateCertificateCard({
    super.key,
    required this.id,
    required this.certificateName,
    required this.certificateCompany,
    required this.issueDate,
    required this.expireDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white10,
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(32)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.file_copy, color: Colors.black87,),
              Icon(Icons.check_circle_outline, color: AppColors.primary)
            ],
          ),
          SizedBox(height: 4),
          Text(certificateName, style: Theme.of(context).textTheme.labelLarge?.copyWith( fontWeight: FontWeight.bold )),
          Text(certificateCompany),
          SizedBox(height: 4),
          Text("Issued: $issueDate"),
          Text("Expired: $expireDate"),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(32)),
            child: Text(status, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold) ),
          )
        ],
      ),
    );
  }
}
