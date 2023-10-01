import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcel_medical_center/blocs/lookup/lookup_bloc.dart';
import 'package:xcel_medical_center/blocs/notification/notification_bloc.dart';
import 'package:xcel_medical_center/config/common_const.dart';
import 'package:xcel_medical_center/model/spider/notification_mod.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/drawer/drawer_menu.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/components/sliding_images.dart';
import 'package:xcel_medical_center/pages/navbar_patient/notification/notification_screen.dart';
import 'package:xcel_medical_center/services/doctor_category_service.dart';
import 'package:xcel_medical_center/pages/navbar_patient/home/view/speciality/doctor_list_page.dart';
import 'package:xcel_medical_center/services/notification/fetch_notification.dart';
import 'package:xcel_medical_center/services/notification/notification_view.dart';
import 'package:xcel_medical_center/services/video_service.dart';
import '../../../model/dept_doctor.dart';
import '../../../model/video.dart';
import '../../../model/video_param.dart';
import 'components/title_widget.dart';
import 'view/speciality/doctor_speciality.dart';
import 'view/tips_and_tricks.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  DeptDoctor doctorCategoryData = DeptDoctor();
  bool isLoadingDoctorCategory = true;

  Video videoData = Video();
  bool isLoadingVideo = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //for notification
      fetchNotification().then((value) {
        notificationList = value["notifications"];
        newNotification = value["new_notification"];
        setState(() {});
      });
      //for notification
    }
  }

  @override
  void initState() {
    //for notification
    fetchNotification().then((value) {
      notificationList = value["notifications"];
      newNotification = value["new_notification"];
      setState(() {});
    });
    
    //for notification
    VideoParam body = VideoParam();
    body.pTOPICUID = "TIP";
    body.pROLEACID = "P";
    body.pPATIENTID = "";
    VideoService().fetchVideoInfo(body).then((video) {
      setState(() {
        videoData = video;
        isLoadingVideo = false;
      });
    });
    DoctorCategoryService().getDeptWiseDoctorList().then((category) {
      setState(() {
        doctorCategoryData = category;
        isLoadingDoctorCategory = false;
      });
    });
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Doctor> getAllDrList() {
    List<Doctor> allDoctor = [];
    for (int i = 0; i < (doctorCategoryData.items ?? []).length; i++) {
      var item = (doctorCategoryData.items ?? [])[i];
      var doctor2 = item.doctor;
      for (int j = 0; j < (doctor2 ?? []).length; j++) {
        var doc = (doctor2 ?? [])[j];
        doc.deptNM = item.deptName;
        doc.deptN0 = item.deptNo;
        allDoctor.add(doc);
      }
    }
    return allDoctor;
  }

  //for notification
  List<NotificationModel> notificationList = [];
  String newNotification = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: const Text('Xcel Medical Centre'),
        actions: [
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationCountState) {
                newNotification = state.newNotificationCount;
                notificationList = state.notificationList;
                return IconButton(
                  onPressed: () {
                    notificationView();
                    newNotification = '0';
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => NotificationScreen(
                                  notifications: notificationList,
                                ))).then((value) {
                                  setState(() {
                                    
                                  });
                                });
                    context.read<NotificationBloc>().add(NotificationClearEvent());
                  },
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(CupertinoIcons.bell),
                      newNotification != '0'
                          ? CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 7,
                              child: Text(
                                newNotification.length > 1
                                    ? '9+'
                                    : newNotification,
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ));
              } else {
                return IconButton(
                  onPressed: () {
                    notificationView();
                    newNotification = '0';
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => NotificationScreen(
                                  notifications: notificationList,
                                ))).then((value) {
                      setState(() {});
                    });
                  },
                  icon: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      const Icon(CupertinoIcons.bell),
                      newNotification != '0'
                          ? CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              radius: 7,
                              child: Text(
                                newNotification.length > 1
                                    ? '9+'
                                    : newNotification,
                                style: const TextStyle(
                                    fontSize: 8, color: Colors.white),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ));
              }
              },
          )
          ],
      ),
      drawer: const DrawerMenu(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            /* ::::::::::::::::::::::::::::::::: SLIDING IMAGES ::::::::::::::::::::::::::::::::: */
            BlocBuilder<LookupBloc, LookupState>(builder: (context, state) {
              List<String> defaultImageUrls = [
                'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
                'https://images.unsplash.com/photo-1579154204601-01588f351e67?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'
              ];
              if (state is LookupDataState) {
                return SlidingImages(
                  imgUrls: state.galleryItems,
                );
              } else if (state is LookupFailedState) {
                return SlidingImages(
                  imgUrls: defaultImageUrls,
                );
              } else {
                return SlidingImages(
                  imgUrls: defaultImageUrls,
                );
              }
            }),
            // const SlidingImages(),
            /* ::::::::::::::::::::::::::::::::: DOCTOR SPECIALITY ::::::::::::::::::::::::::::::::: */
            const SizedBox(height: 8),
            const TitleWidget(
              // title: 'homePage.title3'.tr().toString(),
              title: "Doctor Speciality",
            ),
            isLoadingDoctorCategory
                ? Center(
                    child: Image.asset(
                      'assets/images/loader.gif',
                      height: 100,
                    ),
                  )
                : SizedBox(
                    height: 195,
                    child: ListView.builder(
                        itemCount: (doctorCategoryData.items ?? []).length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10, bottom: 5),
                        itemBuilder: (context, index) {
                          var info = (doctorCategoryData.items ?? [])[index];
                          var doctors = info.doctor;
                          for (int i = 0; i < (doctors ?? []).length; i++) {
                            var doctor = (doctors ?? [])[i];
                            doctor.deptNM = info.deptName;
                            doctor.deptN0 = info.deptNo;
                          }

                          return InkWell(
                            child: DoctorSpeciality(
                              speciallityNo: info.deptNo.toString(),
                              title: info.deptName,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DoctorListPage(
                                    doctorListByCategory:
                                        doctors, //getAllDrList()
                                    allDoctorList: getAllDrList(), //
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                  ),

            /* ::::::::::::::::::::::::::::::::: TIPS AND TRICKS ::::::::::::::::::::::::::::::::: */
            const SizedBox(height: 10),
            const TitleWidget(title: 'Health Education'),
            isLoadingVideo
                ? Center(
                    child: Image.asset('assets/images/loader.gif', height: 100))
                : SizedBox(
                    height: 170,
                    child: ListView.builder(
                        itemCount: (videoData.pRETRNMSG1 ?? []).length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 10),
                        itemBuilder: (context, index) {
                          var videoInfo = (videoData.pRETRNMSG1 ?? [])[index];
                          return TipsAndTricks(
                            videoUrl: videoInfo.vidUrl,
                            videoTitle: videoInfo.vidTitle,
                            videoDuration: videoInfo.vidDuration,
                          );
                        }),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
