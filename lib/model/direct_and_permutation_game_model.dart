class DirectAndPermutationGameResponseModel {
  DirectAndPermutationGameResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? status;
  final String? message;
  final List<DirectAndPermutationGameResponseData> data;

  factory DirectAndPermutationGameResponseModel.fromJson(
      Map<String, dynamic> json) {
    return DirectAndPermutationGameResponseModel(
      success: json["success"],
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<DirectAndPermutationGameResponseData>.from(json["data"]!
              .map((x) => DirectAndPermutationGameResponseData.fromJson(x))),
    );
  }
}

class DirectAndPermutationGameResponseData {
  DirectAndPermutationGameResponseData({
    required this.id,
    required this.name,
    required this.type,
    required this.image,
    required this.colorCode,
    required this.drawDays,
    required this.drawTime,
  });

  final String? id;
  final String? name;
  final String? type;
  final String? image;
  final String? colorCode;
  final String? drawDays;
  final String? drawTime;

  factory DirectAndPermutationGameResponseData.fromJson(
      Map<String, dynamic> json) {
    return DirectAndPermutationGameResponseData(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      image: json["image"],
      colorCode: json["color_code"],
      drawDays: json["draw_days"],
      drawTime: json["draw_time"],
    );
  }
}
