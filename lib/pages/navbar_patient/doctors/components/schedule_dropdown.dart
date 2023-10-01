import 'package:flutter/material.dart';
import 'package:xcel_medical_center/config/common_const.dart';

class ScheduleDropdown extends StatefulWidget {
  final Function(String)? onValueChanged;
  const ScheduleDropdown({Key? key, @required this.onValueChanged}) : super(key: key);
  @override
  ScheduleDropdownState createState() => ScheduleDropdownState();
}

class ScheduleDropdownState extends State<ScheduleDropdown> {
  Schedule? valueUp;
  List<Schedule> allSchedule = [
    Schedule(timeSlot: '08:30 AM', id: '01'),
    Schedule(timeSlot: '09:30 AM', id: '02'),
    Schedule(timeSlot: '10:30 AM', id: '03'),
    Schedule(timeSlot: '11:30 AM', id: '04'),
    Schedule(timeSlot: '12:30 PM', id: '05'),
    Schedule(timeSlot: '01:30 PM', id: '06'),
    Schedule(timeSlot: '02:30 PM', id: '07'),
    Schedule(timeSlot: '03:30 PM', id: '08'),
    Schedule(timeSlot: '04:30 PM', id: '09'),
    Schedule(timeSlot: '05:30 PM', id: '10'),
    Schedule(timeSlot: '06:30 PM', id: '11'),
    Schedule(timeSlot: '07:30 PM', id: '12'),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: cViolet),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonFormField<Schedule>(
          isExpanded: true,
          decoration: const InputDecoration(enabledBorder: InputBorder.none),
          hint: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text("Select Schedule"),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(color: Colors.black),
          validator: (newVal) => newVal == null ? ' * required' : null,
          items: allSchedule.map((val) {
            return DropdownMenuItem<Schedule>(
              value: val,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(val.timeSlot??''),
              ),
            );
          }).toList(),
          value: valueUp,
          onChanged: (value) {
            setState(() {
              valueUp = value;
            });
            if (value != null) {
              widget.onValueChanged!(value.timeSlot??'');
            debugPrint("value.timeSlot: ${value.timeSlot??''}");
            }
            
          },
        )),
    );
  }
}

class Schedule {
  final String? timeSlot;
  final String? id;

  Schedule({@required this.timeSlot, @required this.id});
}
