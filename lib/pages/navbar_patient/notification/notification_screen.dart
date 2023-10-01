import 'package:flutter/material.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:xcel_medical_center/model/spider/notification_mod.dart';
import 'package:xcel_medical_center/pages/navbar_patient/notification/components/empty_notification.dart';
import 'package:xcel_medical_center/services/notification/notification_view.dart';
import 'package:xcel_medical_center/utils/text_trim_length.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.notifications});
  final List<NotificationModel> notifications;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
      ),
      body:
          widget.notifications.isEmpty
              ? const EmptyNotification()
              : 
              ListView.builder(
                  itemCount: widget.notifications.length,
                  itemBuilder: (_, index) {
                    var data = widget.notifications[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      elevation: 0,
                      color: data.viewedFlg == 0
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .surfaceVariant
                              .withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichReadMoreText.fromString(
                              text: data.mesagBody ?? '',
                              settings: LengthModeSettings(
                                trimLength: textTrimLength(data.mesagBody ?? ''),
                                trimCollapsedText: '...See more',
                                trimExpandedText: ' See less ',
                                moreStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.primary),
                                lessStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.primary),
                                onPressReadMore: () {
                                  if (data.viewedFlg != 0) {
                                    return;
                                  }
                                  messageReadUrl(data.messageId.toString())
                                      .then((value) {
                                    if (value) {
                                      setState(() {
                                        data.viewedFlg = 1;
                                      });
                                    }
                                  });
                                },
                              ),
                            ),
                            Text('${data.enteredAt}',style: const TextStyle(color: Colors.blueGrey,fontSize: 10),)
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
