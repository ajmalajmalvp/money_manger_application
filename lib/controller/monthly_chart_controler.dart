import 'package:flutter_money_mangement_application/controller/chart_controller.dart';
import 'package:intl/intl.dart';


class MonthlyChartContollrt extends ChartController {
  @override
  next() {
    startDate = DateTime(startDate.year, startDate.month + 1, 1);
    endDate = DateTime(startDate.year, startDate.month + 1, 1);
    setDateFilter(startDate, endDate);
  }

  @override
  prev() {
    startDate = DateTime(startDate.year, startDate.month - 1, 1);
    endDate = DateTime(startDate.year, startDate.month + 1, 1);
    setDateFilter(startDate, endDate);
  }

  @override
  String getPeriod() {
    return '${DateFormat('MMM ').format(startDate).toUpperCase()} ${startDate.year}';
  }
}