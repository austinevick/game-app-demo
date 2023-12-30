class LoginModel {
  LoginModel({
    required this.username,
    required this.password,
  });

  final String? username;
  final String? password;

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "device_token": 'nostrum',
        "device_type": 'android',
      };
}

class LoginResponseModel {
  LoginResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? status;
  final String? message;
  final LoginResponseData? data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json["success"],
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : LoginResponseData.fromJson(json["data"]),
    );
  }
}

class LoginResponseData {
  LoginResponseData({
    required this.token,
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.surname,
    required this.username,
    required this.dob,
    required this.email,
    required this.gender,
    required this.mobileNumber,
    required this.address,
    required this.nationalIdentificationNumber,
    required this.bank,
    required this.bankAccountNumber,
    required this.bankVerificationNumber,
    required this.profileImage,
    required this.emailVerified,
    required this.phoneVerified,
    required this.userType,
    required this.status,
    required this.payoutMode,
    required this.disabled,
    required this.dateOfJoining,
  });

  final String? token;
  final int? id;
  final String? firstName;
  final dynamic middleName;
  final String? surname;
  final String? username;
  final DateTime? dob;
  final String? email;
  final String? gender;
  final String? mobileNumber;
  final Address? address;
  final dynamic nationalIdentificationNumber;
  final Bank? bank;
  final String? bankAccountNumber;
  final String? bankVerificationNumber;
  final String? profileImage;
  final bool? emailVerified;
  final bool? phoneVerified;
  final String? userType;
  final String? status;
  final String? payoutMode;
  final dynamic disabled;
  final DateTime? dateOfJoining;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      token: json["token"],
      id: json["id"],
      firstName: json["first_name"],
      middleName: json["middle_name"],
      surname: json["surname"],
      username: json["username"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      email: json["email"],
      gender: json["gender"],
      mobileNumber: json["mobile_number"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      nationalIdentificationNumber: json["national_identification_number"],
      bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
      bankAccountNumber: json["bank_account_number"],
      bankVerificationNumber: json["bank_verification_number"],
      profileImage: json["profile_image"],
      emailVerified: json["email_verified"],
      phoneVerified: json["phone_verified"],
      userType: json["user_type"],
      status: json["status"],
      payoutMode: json["payout_mode"],
      disabled: json["disabled"],
      dateOfJoining: DateTime.tryParse(json["date_of_joining"] ?? ""),
    );
  }
}

class Address {
  Address({
    required this.id,
    required this.city,
    required this.state,
    required this.lga,
  });

  final int? id;
  final City? city;
  final State? state;
  final dynamic lga;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json["id"],
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      state: json["state"] == null ? null : State.fromJson(json["state"]),
      lga: json["lga"],
    );
  }
}

class City {
  City({
    required this.id,
    required this.name,
  });

  final int? id;
  final String? name;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json["id"],
      name: json["name"],
    );
  }
}

class State {
  State({
    required this.id,
    required this.countryId,
    required this.countryName,
    required this.name,
  });

  final int? id;
  final int? countryId;
  final String? countryName;
  final String? name;

  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      id: json["id"],
      countryId: json["country_id"],
      countryName: json["country_name"],
      name: json["name"],
    );
  }
}

class Bank {
  Bank({
    required this.bankName,
    required this.bankCode,
  });

  final String? bankName;
  final String? bankCode;

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      bankName: json["bank_name"],
      bankCode: json["bank_code"],
    );
  }
}
