class BookingModel {
  dynamic bookingId;
  dynamic bookingNumber;
  dynamic bookingDate;
  dynamic bookingStatus;
  Patient? patient;
  Nurse? nurse;
  Service? service;

  BookingModel(
      {this.bookingId,
      this.bookingNumber,
      this.bookingDate,
      this.bookingStatus,
      this.patient,
      this.nurse,
      this.service});

  BookingModel.fromJson(Map<String, dynamic> json) {
    bookingId = json['booking_id'];
    bookingNumber = json['booking_number'];
    bookingDate = json['booking_date'];
    bookingStatus = json['booking_status'];
    patient =
        json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    nurse = json['nurse'] != null ? Nurse.fromJson(json['nurse']) : null;
    service =
        json['service'] != null ? Service.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['booking_id'] = bookingId;
    data['booking_number'] = bookingNumber;
    data['booking_date'] = bookingDate;
    data['booking_status'] = bookingStatus;
    if (patient != null) {
      data['patient'] = patient!.toJson();
    }
    if (nurse != null) {
      data['nurse'] = nurse!.toJson();
    }
    if (service != null) {
      data['service'] = service!.toJson();
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
  dynamic houseNumber;
  dynamic address;
  dynamic street;
  dynamic postalCode;
  dynamic city;
  dynamic rating;

  Patient(
      {this.id,
      this.name,
        this.bookingName,
        this.profileName,
      this.photo,
      this.houseNumber,
      this.address,
      this.street,
      this.postalCode,
      this.city,
      this.rating});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bookingName= json['booking_name'];
    profileName = json['profile_name'];
    photo = json['photo'];
    houseNumber = json['house_number'];
    address = json['address'];
    street = json['street'];
    postalCode = json['postal-code'];
    city = json['city'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['booking_name'] = bookingName;
    data['profile_name'] = profileName;
    data['photo'] = photo;
    data['address'] = address;
     data['house_number']= houseNumber;
    data['street'] = street;
    data['postal-code'] = postalCode;
    data['city'] = city;
    data['rating'] = rating;
    return data;
  }
}

class Nurse {
  dynamic id;
  dynamic name;
  dynamic photo;
  dynamic rating;

  Nurse({this.id, this.name, this.photo});

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

class Service {
  dynamic id;
  dynamic name;

  Service({this.id, this.name});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
