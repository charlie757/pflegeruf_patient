class ViewBookingModel {
  dynamic status;
  dynamic code;
  dynamic authStatus;
  dynamic message;
  Data? data;

  ViewBookingModel(
      {this.status, this.code, this.authStatus, this.message, this.data});

  ViewBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    authStatus = json['authStatus'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['code'] = code;
    data['authStatus'] = authStatus;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  MyListing? myListing;

  Data({this.myListing});

  Data.fromJson(Map<String, dynamic> json) {
    myListing = json['myListing'] != null
        ? MyListing.fromJson(json['myListing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (myListing != null) {
      data['myListing'] = myListing!.toJson();
    }
    return data;
  }
}

class MyListing {
  dynamic bookingId;
  dynamic bookingNumber;
  dynamic bookingDate;
  dynamic bookingStatus;
  dynamic bookingMessage;
  dynamic bookingMessage2;
  dynamic nurseDoc;
  Patient? patient;
  Service? service;
  Nurse? nurse;

  MyListing(
      {this.bookingId,
      this.bookingNumber,
      this.bookingDate,
      this.bookingStatus,
      this.bookingMessage,
        this.bookingMessage2,
        this.nurseDoc,
      this.patient,
      this.service,
      this.nurse});

  MyListing.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingNumber = json['booking_number'];
    bookingDate = json['booking_date'];
    bookingStatus = json['booking_status'];
    bookingMessage = json['booking_message'];
    bookingMessage2= json['booking_message2'];
    nurseDoc = json['nurse_doc'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
    nurse = json['nurse'] != null ? Nurse.fromJson(json['nurse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['booking_id'] = bookingId;
    data['booking_number'] = bookingNumber;
    data['booking_date'] = bookingDate;
    data['booking_status'] = bookingStatus;
    data['booking_message'] = bookingMessage;
    data['booking_message2'] = bookingMessage2;
    data['nurse_doc'] = nurseDoc;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (nurse != null) {
      data['nurse'] = nurse!.toJson();
    }
    return data;
  }
}

class Patient {
  dynamic id;
  dynamic name;
  dynamic bookingName;
  dynamic profileName;
  dynamic photo;
  dynamic insurance;
  dynamic insuranceNumber;
  dynamic dob;
  dynamic houseNumber;
  dynamic address;
  dynamic street;
  dynamic postalCode;
  dynamic city;
  dynamic rating;
  dynamic ratedByPatient;
  Patient(
      {this.id,
      this.name,
        this.profileName,
        this.bookingName,
      this.photo,
      this.insurance,
      this.insuranceNumber,
      this.dob,
      this.houseNumber,
      this.address,
      this.street,
      this.postalCode,
      this.city,
      this.rating,this.ratedByPatient});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bookingName= json['booking_name'];
    profileName = json['profile_name'];
    photo = json['photo'];
    insurance = json['insurance'];
    insuranceNumber = json['insurance_number'];
    dob = json['dob'];
    houseNumber = json['house_number'];
    address = json['address'];
    street = json['street'];
    postalCode = json['postal-code'];
    city = json['city'];
    rating = json['rating'];
    ratedByPatient =json['ratedbypatient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['booking_name'] = bookingName;
    data['profile_name'] = profileName;
    data['photo'] = photo;
    data['insurance'] = insurance;
    data['insurance_number'] = insuranceNumber;
    data['dob'] = dob;
   data['house_number']= houseNumber ;
    data['address'] = address;
    data['street'] = street;
    data['postal-code'] = postalCode;
    data['city'] = city;
    data['rating'] = rating;
    data['ratedbypatient']=ratedByPatient;
    return data;
  }
}

class Service {
  dynamic id;
  dynamic name;

  Service({this.id, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Nurse {
  dynamic id;
  dynamic name;
  dynamic photo;
  dynamic rating;

  Nurse({this.id, this.name, this.photo, this.rating});

  Nurse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['rating'] = rating;
    return data;
  }
}
