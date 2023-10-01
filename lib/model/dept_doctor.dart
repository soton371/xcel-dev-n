import 'dart:convert';

DeptDoctor decodeDepDoctorDataFromJson(String str) => DeptDoctor.fromJson(json.decode(str));
String encodeDepDoctorDataToJson(DeptDoctor data) => json.encode(data.toJson());

class DeptDoctor {
  List<Items>? items;
  bool? hasMore;
  int? limit;
  int? offset;
  int? count;
  List<Links>? links;

  DeptDoctor(
      {this.items,
        this.hasMore,
        this.limit,
        this.offset,
        this.count,
        this.links});

  DeptDoctor.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = hasMore;
    data['limit'] = limit;
    data['offset'] = offset;
    data['count'] = count;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? deptName;
  int? deptNo;
  List<Doctor>? doctor;

  Items({this.deptName, this.deptNo, this.doctor});

  Items.fromJson(Map<String, dynamic> json) {
    deptName = json['dept_name'];
    deptNo = json['dept_no'];
    if (json['doctor'] != null) {
      doctor = [];
      json['doctor'].forEach((v) {
        doctor!.add(Doctor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dept_name'] = deptName;
    data['dept_no'] = deptNo;
    if (doctor != null) {
      data['doctor'] = doctor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String? doctorNo;
  String? doctorName;
  String? photoLoca;
  String? qualification;
  int? consultFee;
  String? rating;
  String? deptNM;
  int? deptN0;
  List<DoctorShift>? doctorShift;

  Doctor(
      {this.doctorNo,
        this.doctorName,
        this.photoLoca,
        this.qualification,
        this.consultFee,
        this.rating,
        this.deptNM,
        this.deptN0,
        this.doctorShift});

  Doctor.fromJson(Map<String, dynamic> json) {
    doctorNo = json['doctor_no'];
    doctorName = json['doctor_name'];
    photoLoca = json['photo_loca'];
    qualification = json['qualification'];
    consultFee = json['consult_fee'];
    rating = json['rating'];
    deptNM = json['deptNM'];
    deptN0 = json['deptN0'];
    if (json['doctor_shift'] != null) {
      doctorShift = [];
      json['doctor_shift'].forEach((v) {
        doctorShift!.add(DoctorShift.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctor_no'] = doctorNo;
    data['doctor_name'] = doctorName;
    data['photo_loca'] = photoLoca;
    data['qualification'] = qualification;
    data['consult_fee'] = consultFee;
    data['rating'] = rating;
    data['deptNM'] = deptNM;
    data['deptN0'] = deptN0;
    if (doctorShift != null) {
      data['doctor_shift'] = doctorShift!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DoctorShift {
  int? shiftmstId;
  String? shiftDt;
  String? dy;
  List<ShiftSlot>? shiftSlot;

  DoctorShift({this.shiftmstId, this.shiftDt, this.dy, this.shiftSlot});

  DoctorShift.fromJson(Map<String, dynamic> json) {
    shiftmstId = json['shiftmst_id'];
    shiftDt = json['shift_dt'];
    dy = json['dy'];
    if (json['shift_slot'] != null) {
      shiftSlot = [];
      json['shift_slot'].forEach((v) {
        shiftSlot!.add(ShiftSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shiftmst_id'] = shiftmstId;
    data['shift_dt'] = shiftDt;
    data['dy'] = dy;
    if (shiftSlot != null) {
      data['shift_slot'] = shiftSlot!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  String shiftAsString() {
    return '$shiftDt';
  }

}

class ShiftSlot {
  int? shiftchdId;
  String? timeSlot;
  String? slotsTime;
  String? sloteTime;

  ShiftSlot({this.shiftchdId, this.timeSlot, this.slotsTime, this.sloteTime});

  ShiftSlot.fromJson(Map<String, dynamic> json) {
    shiftchdId = json['shiftchd_id'];
    timeSlot = json['time_slot'];
    slotsTime = json['slots_time'];
    sloteTime = json['slote_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shiftchd_id'] = shiftchdId;
    data['time_slot'] = timeSlot;
    data['slots_time'] = slotsTime;
    data['slote_time'] = sloteTime;
    return data;
  }
}

class Links {
  String? rel;
  String? href;

  Links({this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rel'] = rel;
    data['href'] = href;
    return data;
  }
}
