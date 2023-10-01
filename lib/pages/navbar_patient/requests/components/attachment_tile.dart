
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/pages/navbar_patient/requests/components/attachment_picker.dart';

class AttachmentTile extends StatelessWidget {
  final String? reportName;
  final int? investigationId;
  final int? insertFlag;
  final UploadListener? listener;
  const AttachmentTile({
    Key? key,
    @required this.reportName,
    @required this.investigationId,
    @required this.insertFlag,
    this.listener
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: primaryColor.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(reportName??'', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    if(insertFlag == 0){
                    // if(insertFlag != 0){
                      showDialog(
                          context: context,
                          builder: (context){
                            return PickAttachments(imagePath: (path){
                              debugPrint('====>pt>$path');
                            }, investigationId: investigationId,listener: (isSuccess){
                              listener!(isSuccess);
                            },);
                          });
                    }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.green)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: insertFlag == 1 ? Image.asset('assets/images/check_mark.png', height: 24, width: 24) :Text('Upload Request', style: TextStyle(color: primaryColor)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}