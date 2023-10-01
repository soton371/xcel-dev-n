import 'package:cool_alert/cool_alert.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/widgets/custom_button.dart';
import 'package:xcel_medical_center/widgets/custom_text_field.dart';

import '../../../../../model/pay_gateway.dart';
import '../../../../../model/payment_data.dart';
import '../../../../../services/payment_service.dart';
import 'dialog/payment_req_success_dialog.dart';

class PaymentPage extends StatefulWidget {
  final String? consultationFee;
  final DuePayData? payData;
  final PaymentListener? listener;
  const PaymentPage({
    Key? key,
    @required this.consultationFee,
    this.payData,
    this.listener,
  }) : super(key: key);

  @override
  PaymentPageState createState() => PaymentPageState();
}

typedef PaymentListener = void Function(bool isSuccess);
// typedef void PaymentListener(bool isSuccess);

class PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int tabIndex = 0;
  bool isLoading = true;
  List<String> categories = [];
  List<PayGatewayData> gatewayList = [];
  String? msg;
  String comType = "";

  /*:::::::::::::::::::::::::::::::: MOBILE MONEY TAB ::::::::::::::::::::::::::::::::*/
  final TextEditingController trxIdController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  /*:::::::::::::::::::::::::::::::: INSURANCE/CORPORATE TAB ::::::::::::::::::::::::::::::::*/
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyTypeController = TextEditingController();
  final TextEditingController insuranceNoController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Map body = {"P_RETRNMSG0": "", "P_RETRNMSG1": ""};
    PaymentService().getPayGateway(body).then((value) {
      var gateList = value.pRETRNMSG1;
      if (gateList != null && gateList.isNotEmpty) {
        gatewayList.addAll(gateList);
        for (var g in gatewayList) {
          categories.add(g.payGatewayName ?? '');
        }
        _tabController = TabController(vsync: this, length: categories.length);
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payment"),
          automaticallyImplyLeading: true,
          toolbarHeight: 50,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
            tabs: List<Widget>.generate(
              categories.length,
              (int index) {
                return Tab(text: categories[index]);
              },
            ),
          ),
        ),
        body: isLoading
            ? Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  height: 100,
                ),
              )
            : categories.isEmpty
                ? Container()
                : TabBarView(
                    controller: _tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List<Widget>.generate(
                      categories.length,
                      (int index) {
                        PayGatewayData data = gatewayList[tabIndex];
                        var insurances = data.insurance;
                        String gateWayType = data.gatewayType ?? "";
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                "I" == gateWayType
                                    ? Container()
                                    : const HeadingTextTile(
                                        title: "Payment Information"),
                                "I" == gateWayType
                                    ? Container()
                                    : PaymentInfoTextTile(
                                        title: '1. Merchant Number:',
                                        value: data.merchantNo ?? "",
                                      ),
                                "I" == gateWayType
                                    ? Container()
                                    : PaymentInfoTextTile(
                                        title: '2. Momo ID:',
                                        value: data.momoId ?? "",
                                      ),
                                "I" == gateWayType
                                    ? Container()
                                    : const SizedBox(height: 16),
                                "I" == gateWayType
                                    ? Container()
                                    : const HeadingTextTile(
                                        title: "Amount to Pay"),
                                "I" == gateWayType
                                    ? Container()
                                    : const SizedBox(height: 16),
                                "I" == gateWayType
                                    ? Container()
                                    : DottedBorder(
                                        color: Colors.black,
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                        strokeWidth: 1,
                                        child: Text(
                                          "GHC: ${widget.consultationFee}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                const SizedBox(height: 16),

                                const HeadingTextTile(
                                    title: "Payment Instruction"),
                                const SizedBox(height: 16),
                                Text(
                                  data.payInstructions ?? '',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: primaryColor),
                                ),
                                const SizedBox(height: 16),
                                HeadingTextTile(
                                    title: "I" == gateWayType
                                        ? "Provide Your Details "
                                        : "Payment Receipt Details"),
                                const SizedBox(height: 16),
                                msg == null || msg!.isEmpty
                                    ? Container()
                                    : Text(
                                        msg ?? '',
                                        style: TextStyle(
                                            color: msg!.contains("Success")
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                const SizedBox(height: 16),
                                //tabIndex == 0
                                "M" == gateWayType
                                    ? Column(
                                        children: [
                                          CustomTextField(
                                              nameController: trxIdController,
                                              labeltext: 'Your Transaction ID *',
                                              inputType: TYPE_TEXT,
                                              horizontalPadding: 32),

                                              Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                                            child: IntlPhoneField(
                                              controller: mobileNoController,
                                              keyboardType: const TextInputType.numberWithOptions(),
                                              focusNode: FocusNode(canRequestFocus: false),
                                              invalidNumberMessage: '',
                                              decoration: InputDecoration(
                                                labelText: 'Your Mobile No *',
                                                isDense: true,
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(width: 1, color: primaryColor),
                                                ),
                                                border: const OutlineInputBorder(),
                                              ),
                                              languageCode: "en",
                                              onChanged: (phone) {
                                                debugPrint(phone.completeNumber);
                                              },
                                              initialCountryCode: "GH",
                                            ),
                                          ),
                                          /*
                                          CustomTextField(
                                              nameController:
                                                  mobileNoController,
                                              labeltext: 'Your Mobile No *',
                                              inputType: TYPE_PHONE,
                                              horizontalPadding: 32),
                                              */
                                          //  CustomTextField(nameController: amountController, labeltext: 'Amount', inputType: TYPE_NUMBER, horizontalPadding: 32),
                                        ],
                                      )
                                    : "I" == gateWayType
                                        ? Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32),
                                                child:
                                                    DropdownSearch<Insurance>(
                                                  popupProps:
                                                      const PopupProps.menu(
                                                    showSearchBox: true,
                                                  ),
                                                  dropdownDecoratorProps:
                                                      const DropDownDecoratorProps(
                                                    dropdownSearchDecoration:
                                                        InputDecoration(
                                                      hintText:
                                                          "Select Company",
                                                      labelText:
                                                          "Select Company *",
                                                      helperText:
                                                          'Please Select Company First',
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              12, 12, 0, 0),
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),

                                                  //  showSelectedItem: true,
                                                  items: insurances ?? [],
                                                  itemAsString:
                                                      (Insurance? u) => u !=
                                                              null
                                                          ? u.gatewayAsString()
                                                          : '',
                                                  onChanged: (Insurance? data) {
                                                    setState(() {
                                                      var insuranceComId = data !=
                                                              null
                                                          ? data.payGatewayChdNo
                                                          : 0;
                                                      companyNameController
                                                              .text =
                                                          insuranceComId
                                                              .toString();
                                                      companyTypeController
                                                          .text = data !=
                                                              null
                                                          ? data.companyType ??
                                                              ""
                                                          : '';
                                                      comType = data != null
                                                          ? data.companyType ??
                                                              ""
                                                          : '';
                                                      debugPrint(
                                                          "============$insuranceComId");
                                                    });
                                                  },
                                                  //   selectedItem: "Brazil"
                                                ),
                                              ),
                                              // CustomTextField(nameController: companyNameController, inputType: TYPE_TEXT, labeltext: 'Company Name', horizontalPadding: 32),
                                              CustomTextField(
                                                  nameController:
                                                      insuranceNoController,
                                                  inputType: TYPE_TEXT,
                                                  labeltext:
                                                      'Insurance/Corporate Number *',
                                                  horizontalPadding: 32),
                                              // CustomTextField(nameController: expDateController, inputType: TYPE_TEXT, labeltext: 'Expiry Date (Insurance Only)', horizontalPadding: 32),
                                              "C" == comType
                                                  ? Container()
                                                  : InkWell(
                                                      customBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 1,
                                                            color:
                                                                primaryColor),
                                                      ),
                                                      onTap: () async {
                                                        final DateTime?
                                                            pickedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate: DateTime
                                                              .now(), //DateTime.now().subtract(Duration(days: 1))
                                                          lastDate: DateTime
                                                                  .now()
                                                              .add(const Duration(
                                                                  days: 3650)),
                                                        );
                                                        if (pickedDate !=
                                                            null) {
                                                          String expDate = DateFormat(
                                                                  "dd-MMM-yyyy")
                                                              .format(
                                                                  pickedDate);
                                                          debugPrint(expDate);
                                                          setState(() {
                                                            expDateController
                                                                .text = expDate;
                                                          });
                                                        }
                                                        
                                                      },
                                                      child: Container(
                                                        height: 50,
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        margin: const EdgeInsets
                                                                .fromLTRB(
                                                            32, 12, 32, 5),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    primaryColor)),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Center(
                                                                child: Text(expDateController
                                                                        .text
                                                                        .isEmpty
                                                                    ? 'Expiry Date *'
                                                                    : 'Expiry Date: ${expDateController.text}')),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                              CustomTextField(
                                                  nameController:
                                                      remarksController,
                                                  inputType: TYPE_TEXT,
                                                  labeltext:
                                                      'Enter Your Remarks',
                                                  horizontalPadding: 32),
                                            ],
                                          )
                                        : Container(),
                                const SizedBox(height: 30),

                                CustomButton(
                                  btnColor: primaryColor,
                                  btnText: 'Submit',
                                  onTap: () {
                                    var trxId = trxIdController.text;
                                    var senderMobile = mobileNoController.text;
                                    // var amount = amountController.text;
                                    var insuranceNo =
                                        companyNameController.text;
                                    var corporateNo =
                                        insuranceNoController.text;
                                    var expDate = expDateController.text;
                                    var remarks = remarksController.text;

                                    if ("M" == gateWayType && trxId.trim().isEmpty) {
                                      setState(() {
                                        msg = "Please Input Transaction ID";
                                      });
                                    } else if ("M" == gateWayType &&
                                        senderMobile.trim().isEmpty) {
                                      setState(() {
                                        msg =
                                            "Please Input Sender Mobile Number";
                                      });
                                    } else if ("M" == gateWayType &&
                                        senderMobile.trim().isNotEmpty && RegExp(r'[.,]').hasMatch(senderMobile.trim())) {
                                      setState(() {
                                        msg =
                                            "Please Input Sender Valid Mobile Number";
                                      });
                                    }
                                    else if ("I" == gateWayType &&
                                        insuranceNo.trim().isEmpty) {
                                      setState(() {
                                        msg = "Please Select Company";
                                      });
                                    } else if ("I" == gateWayType &&
                                        corporateNo.trim().isEmpty) {
                                      setState(() {
                                        msg =
                                            "Please Input Insurance/Corporate No";
                                      });
                                    } else if ("I" == gateWayType &&
                                        expDate.trim().isEmpty &&
                                        "I" == comType) {
                                      setState(() {
                                        msg = "Please Input Expiry Date";
                                      });
                                    } else {
                                      setState(() {
                                        msg = null;
                                      });
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.warning,
                                        showCancelBtn: true,
                                        confirmBtnText: "Submit",
                                        title: "Submission Alert!",
                                        text: "Do you want to submit?",
                                        onConfirmBtnTap: () async {
                                          /* setState(() {
                                  isLoading = true;
                                });*/
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          var payData2 = widget.payData;
                                          Map body = {
                                            "P_REQBILLID":
                                                widget.payData == null
                                                    ? 0
                                                    : payData2 != null
                                                        ? payData2.reqBillId
                                                        : 0,
                                            "P_PAYMNTTYP": data.gatewayType,
                                            "P_PAYMNTAMT":
                                                widget.consultationFee,
                                            "P_INSURANCE": insuranceNo,
                                            "P_CORPORTNO": corporateNo,
                                            "P_EXPIRYDAT": expDate,
                                            "P_BANKS_IDS": "",
                                            "P_CHEQUE_NO": "",
                                            "P_CHQDUEDAT": "",
                                            "P_TRANSC_ID": trxId,
                                            "P_MOBILE_NO": senderMobile,
                                            "P_MOMONUMBR": data.momoId,
                                            "P_GATEWAYNO": data.payGatewayNo,
                                            "P_SAUSERSID":
                                                prefs.getInt(prefUserId),
                                            "P_COMPANYID": "",
                                            "P_COMMENTSD": remarks,
                                            "P_RETRNMSG0": ""
                                          };

                                          PaymentService()
                                              .submitPayment(body)
                                              .then((value) async {
                                            // if(value != null){
                                            if (value.isNotEmpty) {
                                              String msg = value["P_RETRNMSG0"];
                                              String msg1 = msg.isEmpty
                                                  ? "Submit failed"
                                                  : msg;
                                              String code =
                                                  value["P_RETRNMSGN"];
                                              debugPrint('$msg  ==  $code');
                                              if (code.contains("200")) {
                                                setState(() {
                                                  msg = msg;
                                                });
                                                await showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    var payData3 =
                                                        widget.payData;
                                                    return PaymentReqSuccessDialog(
                                                      doctorName:
                                                          payData3 != null
                                                              ? payData3
                                                                  .doctorService
                                                              : '',
                                                      consultationDate:
                                                          payData3 != null
                                                              ? payData3
                                                                  .appointDate
                                                              : '',
                                                      status: 'Paid',
                                                      consultationFee: widget
                                                          .consultationFee,
                                                    );
                                                  },
                                                );
                                                var lis = widget.listener;
                                                if (lis != null) {
                                                  lis(true);
                                                } else {
                                                  debugPrint(
                                                      "widget.listener(true); $lis");
                                                }

                                                // Navigator.pop(context);
                                              } else {
                                                setState(() {
                                                  msg = msg1;
                                                });
                                                await CoolAlert.show(
                                                    context: context,
                                                    type: CoolAlertType.error,
                                                    showCancelBtn: false,
                                                    confirmBtnText: "Ok",
                                                    title: "Submission Alert!!",
                                                    text: msg1);
                                              }
                                              Navigator.of(context).pop();
                                            } else {
                                              setState(() {
                                                msg = "Something went wrong!!!";
                                              });
                                              await CoolAlert.show(
                                                  context: context,
                                                  type: CoolAlertType.error,
                                                  showCancelBtn: false,
                                                  confirmBtnText: "Ok",
                                                  title: "Submission Alert!!",
                                                  text:
                                                      "Something went wrong!!!");
                                            }
                                            Navigator.of(context).pop();
                                          });
                                        },
                                      );
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}

Future alertDialog(BuildContext context) {
  debugPrint('calling........');
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Done'),
          content: const Text('Add Success'),
          actions: <Widget>[
            CustomButton(
                btnColor: primaryColor,
                btnText: 'Ok',
                onTap: () => Navigator.pop(context))
          ],
        );
      });
}

/*:::::::::::::::::::::::::::::::::::::::::: WIDGETS ::::::::::::::::::::::::::::::::::::::::::*/
class PaymentInfoTextTile extends StatelessWidget {
  final String? title;
  final String? value;
  const PaymentInfoTextTile({
    Key? key,
    @required this.title,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(title ?? '', style: const TextStyle(fontSize: 15))),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: primaryColor, width: 1.5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingTextTile extends StatelessWidget {
  final String? title;
  const HeadingTextTile({
    Key? key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Center(
        child: Text(
          title ?? '',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
