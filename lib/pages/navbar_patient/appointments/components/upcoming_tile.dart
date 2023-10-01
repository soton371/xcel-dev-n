import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class UpcomingTile extends StatelessWidget {
  final String? appointmentDate;
  final String? doctorName;
  final String? drSpeciality;
  final String? serialNo;
  final String? consultTypeNo;
  final VoidCallback? onTapVideo;
  const UpcomingTile({
    Key? key,
    @required this.appointmentDate,
    @required this.doctorName,
    @required this.drSpeciality,
    @required this.serialNo,
    @required this.consultTypeNo,
    @required this.onTapVideo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 5),
                ),
                child: Center(
                  child: Text(serialNo??'', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor)),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: primaryColor.withOpacity(0.1),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width - 204,
                          child: Text(
                            appointmentDate??'',
                            style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                          ),
                        ),
                        consultTypeNo == "1" ? Container(height: 45,) : IconButton(
                          icon: Icon(Icons.videocam, color: primaryColor, size: 30),
                          onPressed: (){
                            onTapVideo!();
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(doctorName??'', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(drSpeciality??'', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text(consultTypeNo == "1" ? "Direct Visit" : "Online", style: const TextStyle(fontSize: 15, color: Colors.green)),
                 // SizedBox(height: 5),
                 // Text(serialNo, style: TextStyle(fontSize: 15, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}