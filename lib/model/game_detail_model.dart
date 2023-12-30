class GamedetailModel {
  GamedetailModel({
    required this.gameId,
  });

  final List<int> gameId;

  Map<String, dynamic> toMap() => {
        "game_id": List<dynamic>.from(gameId.map((x) => x)),
      };
}

class GamedetailResponseModel {
  GamedetailResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? success;
  final int? status;
  final String? message;
  final List<GamedetailResponseData> data;

  factory GamedetailResponseModel.fromJson(Map<String, dynamic> json) {
    return GamedetailResponseModel(
      success: json["success"],
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<GamedetailResponseData>.from(
              json["data"]!.map((x) => GamedetailResponseData.fromJson(x))),
    );
  }
}

class GamedetailResponseData {
  GamedetailResponseData({
    required this.id,
    required this.title,
    required this.gameTypeId,
    required this.gameType,
    required this.startNumber,
    required this.endNumber,
    required this.ballStartNumber,
    required this.ballEndNumber,
    required this.pickNumberCount,
    required this.ballNumberCount,
    required this.availableTicketQty,
    required this.amount,
    required this.minAmount,
    required this.maxAmount,
    required this.ticketSaleDeadline,
    this.selectedNoOfTicket,
    required this.status,
  });

  final int? id;
  final String? title;
  final int? gameTypeId;
  final String? gameType;
  final String? startNumber;
  final String? endNumber;
  final String? ballStartNumber;
  final String? ballEndNumber;
  final String? pickNumberCount;
  final String? ballNumberCount;
  final String? availableTicketQty;
  final String? amount;
  final String? minAmount;
  final String? maxAmount;
  final String? ticketSaleDeadline;
  final String? status;
  int? selectedNoOfTicket = 1;

  factory GamedetailResponseData.fromJson(Map<String, dynamic> json) {
    return GamedetailResponseData(
      id: json["id"],
      title: json["title"],
      gameTypeId: json["game_type_id"],
      gameType: json["game_type"],
      startNumber: json["start_number"],
      endNumber: json["end_number"],
      ballStartNumber: json["ball_start_number"],
      ballEndNumber: json["ball_end_number"],
      pickNumberCount: json["pick_number_count"],
      ballNumberCount: json["ball_number_count"],
      availableTicketQty: json["available_ticket_qty"],
      amount: json["amount"],
      minAmount: json["min_amount"],
      maxAmount: json["max_amount"],
      ticketSaleDeadline: json["ticket_sale_deadline"],
      status: json["status"],
    );
  }
}
