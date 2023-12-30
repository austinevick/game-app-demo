class PlayersResponseModel {
  PlayersResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
    required this.links,
    required this.meta,
  });

  final bool? success;
  final int? status;
  final String? message;
  final List<PlayersResponseData> data;
  final Links? links;
  final Meta? meta;

  factory PlayersResponseModel.fromJson(Map<String, dynamic> json) {
    return PlayersResponseModel(
      success: json["success"],
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<PlayersResponseData>.from(
              json["data"]!.map((x) => PlayersResponseData.fromJson(x))),
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }
}

class PlayersResponseData {
  PlayersResponseData({
    required this.id,
    required this.name,
    required this.username,
    required this.mobileNumber,
    required this.profileImage,
    required this.bankName,
    required this.accountNumber,
    required this.bankCode,
  });

  final String? id;
  final String? name;
  final String? username;
  final String? mobileNumber;
  final String? profileImage;
  final String? bankName;
  final String? accountNumber;
  final String? bankCode;

  factory PlayersResponseData.fromJson(Map<String, dynamic> json) {
    return PlayersResponseData(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      mobileNumber: json["mobile_number"],
      profileImage: json["profile_image"],
      bankName: json["bank_name"],
      accountNumber: json["account_number"],
      bankCode: json["bank_code"],
    );
  }
}

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json["first"],
      last: json["last"],
      prev: json["prev"],
      next: json["next"],
    );
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"],
      lastPage: json["last_page"],
      perPage: json["per_page"],
      total: json["total"],
    );
  }
}
