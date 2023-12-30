import 'dart:convert';

String addBookingRequestModelToJson(AddBookingRequestModel data) =>
    json.encode(data.toJson());

class AddBookingRequestModel {
  dynamic data;

  AddBookingRequestModel({
    this.data,
  });

  Map<String, dynamic> toJson() => {
        'data': data,
      };
}

AddBookingResponseModel addBookingResponseModelFromJson(String str) =>
    AddBookingResponseModel.fromJson(json.decode(str));

String addBookingResponseModelToJson(AddBookingResponseModel data) =>
    json.encode(data.toJson());

class AddBookingResponseModel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  AddBookingResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory AddBookingResponseModel.fromJson(Map<String, dynamic> json) =>
      AddBookingResponseModel(
        success: json['success'],
        status: json['status'],
        message: json['message'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class Data {
  String? id;
  String? userId;
  String? userType;
  String? vendorId;
  String? subvendorId;
  String? paymentType;
  String? paymentStatus;
  String? totalPayable;
  String? couponDiscount;
  DateTime? bookingDate;
  List<BookedGame>? bookedGames;

  Data({
    this.id,
    this.userId,
    this.userType,
    this.vendorId,
    this.subvendorId,
    this.paymentType,
    this.paymentStatus,
    this.totalPayable,
    this.couponDiscount,
    this.bookingDate,
    this.bookedGames,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'],
        userId: json['user_id'],
        userType: json['user_type'],
        vendorId: json['vendor_id'],
        subvendorId: json['subvendor_id'],
        paymentType: json['payment_type'],
        paymentStatus: json['payment_status'],
        totalPayable: json['total_payable'],
        couponDiscount: json['coupon_discount'],
        bookingDate: json['booking_date'] == null
            ? null
            : DateTime.parse(json['booking_date']),
        bookedGames: json['booked_games'] == null
            ? []
            : List<BookedGame>.from(
                json['booked_games']!.map((x) => BookedGame.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'user_type': userType,
        'vendor_id': vendorId,
        'subvendor_id': subvendorId,
        'payment_type': paymentType,
        'payment_status': paymentStatus,
        'total_payable': totalPayable,
        'coupon_discount': couponDiscount,
        'booking_date': bookingDate?.toIso8601String(),
        'booked_games': bookedGames == null
            ? []
            : List<dynamic>.from(bookedGames!.map((x) => x.toJson())),
      };
}

class BookedGame {
  String? id;
  String? bookingId;
  GameData? gameData;
  String? noOfTickets;
  String? amountPerTicket;
  String? totalAmount;
  List<dynamic>? bookedGameTickets;

  BookedGame({
    this.id,
    this.bookingId,
    this.gameData,
    this.noOfTickets,
    this.amountPerTicket,
    this.totalAmount,
    this.bookedGameTickets,
  });

  factory BookedGame.fromJson(Map<String, dynamic> json) => BookedGame(
        id: json['id'],
        bookingId: json['booking_id'],
        gameData: json['game_data'] == null
            ? null
            : GameData.fromJson(json['game_data']),
        noOfTickets: json['no_of_tickets'],
        amountPerTicket: json['amount_per_ticket'],
        totalAmount: json['total_amount'],
        bookedGameTickets: json['booked_game_tickets'] == null
            ? []
            : List<dynamic>.from(json['booked_game_tickets']!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'booking_id': bookingId,
        'game_data': gameData?.toJson(),
        'no_of_tickets': noOfTickets,
        'amount_per_ticket': amountPerTicket,
        'total_amount': totalAmount,
        'booked_game_tickets': bookedGameTickets == null
            ? []
            : List<dynamic>.from(bookedGameTickets!.map((x) => x)),
      };
}

class GameData {
  int? id;
  String? title;
  int? gameTypeId;
  String? gameType;
  String? startNumber;
  String? endNumber;
  String? ballStartNumber;
  String? ballEndNumber;
  String? pickNumberCount;
  String? ballNumberCount;
  String? availableTicketQty;
  String? amount;
  String? minAmount;
  String? maxAmount;
  String? ticketSaleDeadline;
  String? status;

  GameData({
    this.id,
    this.title,
    this.gameTypeId,
    this.gameType,
    this.startNumber,
    this.endNumber,
    this.ballStartNumber,
    this.ballEndNumber,
    this.pickNumberCount,
    this.ballNumberCount,
    this.availableTicketQty,
    this.amount,
    this.minAmount,
    this.maxAmount,
    this.ticketSaleDeadline,
    this.status,
  });

  factory GameData.fromJson(Map<String, dynamic> json) => GameData(
        id: json['id'],
        title: json['title'],
        gameTypeId: json['game_type_id'],
        gameType: json['game_type'],
        startNumber: json['start_number'],
        endNumber: json['end_number'],
        ballStartNumber: json['ball_start_number'],
        ballEndNumber: json['ball_end_number'],
        pickNumberCount: json['pick_number_count'],
        ballNumberCount: json['ball_number_count'],
        availableTicketQty: json['available_ticket_qty'],
        amount: json['amount'],
        minAmount: json['min_amount'],
        maxAmount: json['max_amount'],
        ticketSaleDeadline: json['ticket_sale_deadline'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'game_type_id': gameTypeId,
        'game_type': gameType,
        'start_number': startNumber,
        'end_number': endNumber,
        'ball_start_number': ballStartNumber,
        'ball_end_number': ballEndNumber,
        'pick_number_count': pickNumberCount,
        'ball_number_count': ballNumberCount,
        'available_ticket_qty': availableTicketQty,
        'amount': amount,
        'min_amount': minAmount,
        'max_amount': maxAmount,
        'ticket_sale_deadline': ticketSaleDeadline,
        'status': status,
      };
}
