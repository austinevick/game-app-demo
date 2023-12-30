class GameListResponseModel {
  GameListResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? status;
  final String? message;
  final List<GameListResponseData> data;

  factory GameListResponseModel.fromJson(Map<String, dynamic> json){
    return GameListResponseModel(
      success: json["success"],
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? [] : List<GameListResponseData>.from(json["data"]!.map((x) => GameListResponseData.fromJson(x))),
    );
  }

}

class GameListResponseData {
  GameListResponseData({
    required this.id,
    required this.title,
    required this.image,
    required this.colorCode,
    required this.gameTypeId,
    required this.gameType,
    required this.status,
  });

  final int? id;
  final String? title;
  final String? image;
  final String? colorCode;
  final int? gameTypeId;
  final String? gameType;
  final String? status;

  factory GameListResponseData.fromJson(Map<String, dynamic> json){
    return GameListResponseData(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      colorCode: json["color_code"],
      gameTypeId: json["game_type_id"],
      gameType: json["game_type"],
      status: json["status"],
    );
  }

}
