import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import '../../../../model/payment_data.dart';

class PayTile extends StatelessWidget {
  final String? appointmentDate;
  final String? doctorName;
  final String? serviceName;
  final String? consultationFee;
  final String? msg;
  final DuePayData? data;
  final VoidCallback? onTapPay;
  const PayTile({
    Key? key,
    @required this.appointmentDate,
    @required this.doctorName,
    @required this.serviceName,
    @required this.consultationFee,
    @required this.msg,
    @required this.data,
    @required this.onTapPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int payFlag = data != null ? data!.payFlag ?? 0 : 0;
    int billAcceptFg = data != null ? data!.billAcceptFlag ?? 0 : 0;
    int expireFlag = data != null ? data!.expireFlag ?? 0 : 0;
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appointmentDate ?? '',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                  payFlag == 1 || billAcceptFg > 0 || expireFlag == 1 ? Container() : ElevatedButton(
                    onPressed: () {
                      onTapPay!();
                    },
                    child: const Text('Pay'),
                  ),
                ],
              ),
              Text(doctorName ??'', style: const TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 5),
              Text(serviceName ?? '', style: const TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 5),
              Text(consultationFee ?? '', style: const TextStyle(fontSize: 15, color: Colors.grey)),
              const SizedBox(height: 5),
              msg == null || msg!.isEmpty ? Container() : Container(color: greenLightColor, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text("$msg",  style: const TextStyle(fontSize: 15, color: Colors.black45))),
                // child: Center(child: Text(payFlag == 0 && billAcceptFg == 0 ? "Please pay your bill within 20 minutes":msg ??'',  style: const TextStyle(fontSize: 15, color: Colors.black45))),
              )),

            ],
          ),
        ),
      ),
    );
  }
}

typedef OnTapPay = void Function();
// typedef void OnTapPay();