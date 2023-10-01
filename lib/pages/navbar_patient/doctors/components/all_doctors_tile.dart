import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class AllDoctorTile extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? speciality;
  final String? degree;
  final String? institute;
  final String? rating;
  final String? departmentName;
  final TakeAptDecision? callback;

  const AllDoctorTile({
    Key? key,
    @required this.imageUrl,
    @required this.name,
    @required this.speciality,
    @required this.degree,
    @required this.institute,
    @required this.rating,
    @required this.departmentName,
    @required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFd8ebff),
            blurRadius: 20.0,
            spreadRadius: 0.0,
            offset: Offset(5.0, 5.0),
          )
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ClipOval(
                      child: imageUrl == 'null'
                          ? Image.asset(
                              defaultFemaleAssetImg,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imageUrl ?? '',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Image.asset(
                                "assets/images/avatar.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/avatar.png",
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                      
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '$speciality',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 3),
                        degree == null
                            ? Container()
                            : Text(
                                '$degree',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                        const SizedBox(height: 3),
                        Text(
                          '$departmentName',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '$institute',
                          style: const TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          callback!(2);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text('Online'),
                            SizedBox(width: 5),
                            Icon(CupertinoIcons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          callback!(1);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // <-- Radius
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text('Direct'),
                            SizedBox(width: 5),
                            Icon(CupertinoIcons.calendar_today, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

typedef TakeAptDecision = void Function(int flag);
// typedef void TakeAptDecision(int flag);
