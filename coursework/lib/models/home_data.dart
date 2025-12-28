import 'package:candystore/models/card_data.dart';

class HomeData {
  final List<CardData>? data;
  final int? nextPage;
  final int? currentPage;
  final int? totalPages;

  HomeData({this.data, this.nextPage, this.currentPage, this.totalPages});
}
