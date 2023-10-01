import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class PrescriptionListTile extends StatelessWidget {
  final String? appointmentDate;
  final String? doctorName;
  final String? speciality;
  final VoidCallback? onTap;
  const PrescriptionListTile({
    Key? key,
    @required this.appointmentDate,
    @required this.doctorName,
    @required this.speciality,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: InkWell(
        onTap: () {
          onTap!();
        },
        child: Card(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: primaryColor.withOpacity(0.1),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        height: 40,
                        width: size.width - 60,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            appointmentDate ?? '',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: primaryColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(doctorName ?? '',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Text(speciality ?? '',
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
