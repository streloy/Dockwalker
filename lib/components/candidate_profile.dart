import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dockwalker/utils/AppColors.dart';

class CandidateProfile extends StatelessWidget {
  final dynamic candidate;
  const CandidateProfile({super.key, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0.6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval( child: Image.network( candidate['photo'], width: 56, height: 56, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset( 'assets/logo.png', width: 56, height: 56, fit: BoxFit.cover );
                    }
                  )
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(candidate['fullname'], style: const TextStyle( fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(width: 4),
                          const Icon(Icons.verified, color: AppColors.primary, size: 18),
                        ],
                      ),
                      Text("Job Role", style: const TextStyle( fontSize: 14, color: Colors.black54)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          Text(" 4.8 ", style: const TextStyle(fontWeight: FontWeight.w600)),
                          Text("(18)  •  ", style: const TextStyle(color: Colors.black54)),
                          const Icon(Icons.location_on_outlined, size: 14, color: Colors.black45),
                          Text(candidate['address'], style: const TextStyle(color: Colors.black54)),
                        ],
                      )
                    ],
                  ),
                ),

                // Match %
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text("67%", style: const TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text("Match", style: TextStyle( color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w400)),
                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 12),
            const Divider(),

            // --- Job Info ---
            Row(
              children: [
                const Icon(CupertinoIcons.briefcase, size: 18, color: Colors.black54),
                const SizedBox(width: 6),
                Expanded( child: Text("Applied for: Job Position", style: const TextStyle(color: Colors.black87))),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(CupertinoIcons.time, size: 18, color: Colors.black54),
                const SizedBox(width: 6),
                Text("20 Oct, 2025", style: const TextStyle(color: Colors.black87)),
              ],
            ),

            const SizedBox(height: 10),

            // --- Skills Tags ---
            Wrap(
              spacing: 8,
              runSpacing: 8,
              runAlignment: WrapAlignment.center,
              children: [
                for (var i = 0; i < (candidate['skills_new'].length > 3 ? 3 : candidate['skills_new'].length); i++)
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(candidate['skills_new'][i], style: TextStyle( color: Colors.grey, fontWeight: FontWeight.w700, fontSize: 12)),
                  ),
                if (candidate['skills_new'].length > 3)
                  Text(
                    "+${candidate['skills_new'].length - 3} more",
                    style: TextStyle(color: Colors.black54),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("New", style: TextStyle( color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 12)),
                ),
                Text("6 Years", style: const TextStyle( color: Colors.black54, fontWeight: FontWeight.w500))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
