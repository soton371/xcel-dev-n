import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import '../../../../model/investigation.dart';
import 'attachment_picker.dart';
import 'attachment_tile.dart';

class RequestTile extends StatefulWidget {
  final String? appointmentDate;
  final String? doctorName;
  final String? speciality;
  final List<Investigations>? investigations;
  final UploadListener? listener;
  const RequestTile({
    Key? key,
    @required this.appointmentDate,
    @required this.doctorName,
    @required this.speciality,
    @required this.investigations, this.listener,
  }) : super(key: key);

  @override
  RequestTileState createState() => RequestTileState();
}

class RequestTileState extends State<RequestTile> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.doctorName??'', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                      const SizedBox(height: 5),
                      Text(widget.speciality??'', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                      const SizedBox(height: 5),
                      Text(
                        widget.appointmentDate??'',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: const Text('Tap'),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: ListView.builder(
              itemCount: (widget.investigations??[]).length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              itemBuilder: (context, index) {
                Investigations investigation = (widget.investigations??[])[index];
                return AttachmentTile(
                  reportName: investigation.testName ?? "",
                  investigationId: investigation.investigationId,
                  insertFlag: investigation.uploadFlag,
                    listener: (isSuccess){
                      widget.listener!(isSuccess);
                    },
                );
              }),
          ),
        ],
      ),
    );
  }
}