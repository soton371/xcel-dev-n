import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/model/request_list_mod.dart';
import 'package:xcel_medical_center/services/request/request_action.dart';
import 'package:xcel_medical_center/utils/color_generate.dart';
import 'package:xcel_medical_center/widgets/my_alert.dart';
import 'package:xcel_medical_center/widgets/show_snack.dart';

class RequestList extends StatefulWidget {
  const RequestList(
      {super.key, required this.requestLists, required this.performerId});
  final List<PRetrnmsg1> requestLists;
  final String performerId;

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.requestLists.length,
        itemBuilder: (context, index) {
          PRetrnmsg1 data = widget.requestLists[index];
          return Card(
            elevation: cardEnable(data.statusFlg ?? 0) ? 1 : 0,
            color: cardEnable(data.statusFlg ?? 0)
                ? Theme.of(context).cardTheme.color
                : Theme.of(context).colorScheme.onInverseSurface,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //add for info
                  Row(
                    children: [
                      data.rqstpatId.toString() != widget.performerId.toString()
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 60,
                                fit: BoxFit.cover,
                                imageUrl: data.photoFrom ?? '',
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: 70,
                                width: 60,
                                fit: BoxFit.cover,
                                imageUrl: data.photoTo ?? '',
                                placeholder: (context, url) => Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/images/avatar.png",
                                  height: 70,
                                  width: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.6,
                            child: Text(
                              data.rqstpatId.toString() !=
                                      widget.performerId.toString()
                                  ? data.rqstpatNm ?? ''
                                  : data.rqstforNm ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Text("Request for ${data.reltnName ?? ''}",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              const SizedBox(
                                width: 8,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorGenerate(
                                            context, data.statusFlg ?? 0)),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  data.statusDtl ?? '',
                                  style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .fontSize,
                                      color: colorGenerate(
                                          context, data.statusFlg ?? 0)),
                                ),
                              )
                            ],
                          ),
                          //add for date time
                          Text(
                            data.performAt ?? '',
                            style: Theme.of(context).textTheme.labelMedium,
                          )
                        ],
                      )
                    ],
                  ),

                  //add for action button
                  showAction(data.statusFlg ?? 0)
                      ? Column(
                          children: [
                            const Divider(),
                            Row(
                              children: [
                                Expanded(
                                    child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                        onPressed: () {
                                          myAlertDialog(context,
                                              titleMsg: "Are you sure?",
                                              contentMsg: "Cancel this request",
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      requestAction(
                                                              requestId:
                                                                  "${data.requestId}",
                                                              statusFlag: "2",
                                                              performer: widget
                                                                  .performerId)
                                                          .then((value) {
                                                        if (value) {
                                                          setState(() {
                                                            data.statusFlg = 2;
                                                            data.statusDtl =
                                                                "Canceled";
                                                          });
                                                        } else {
                                                          myToast(
                                                              "Something went wrong.");
                                                        }
                                                      });
                                                    },
                                                    child: const Text('Yes')),
                                              ]);
                                        },
                                        child: Text('Cancel',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)))),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          elevation: 0,
                                        ),
                                        onPressed: () {
                                          myAlertDialog(context,
                                              titleMsg: "Are you sure?",
                                              contentMsg:
                                                  "Confirm this request",
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      requestAction(
                                                              requestId:
                                                                  "${data.requestId}",
                                                              statusFlag: "1",
                                                              performer: widget
                                                                  .performerId)
                                                          .then((value) {
                                                        if (value) {
                                                          setState(() {
                                                            data.statusFlg = 1;
                                                            data.statusDtl =
                                                                "Approved";
                                                          });
                                                        } else {
                                                          myToast(
                                                              "Something went wrong.");
                                                        }
                                                      });
                                                    },
                                                    child: const Text('Yes')),
                                              ]);
                                        },
                                        child: const Text('Confirm',
                                            style: TextStyle(
                                                color: Colors.white)))),
                              ],
                            )
                          ],
                        )
                      : const SizedBox(),

                  //add for cancel button
                  data.rqstpatId.toString() == widget.performerId &&
                          data.statusFlg.toString() == '0'
                      ? Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  onPressed: () {
                                    myAlertDialog(context,
                                        titleMsg: "Are you sure?",
                                        contentMsg: "Cancel this request",
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('No')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                requestAction(
                                                        requestId:
                                                            "${data.requestId}",
                                                        statusFlag: "2",
                                                        performer:
                                                            widget.performerId)
                                                    .then((value) {
                                                  if (value) {
                                                    setState(() {
                                                      data.statusFlg = 2;
                                                      data.statusDtl =
                                                          "Canceled";
                                                    });
                                                  } else {
                                                    myToast(
                                                        "Something went wrong.");
                                                  }
                                                });
                                              },
                                              child: const Text('Yes')),
                                        ]);
                                  },
                                  child: Text('Cancel',
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))),
                            ),
                          ],
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        });
  }
}
