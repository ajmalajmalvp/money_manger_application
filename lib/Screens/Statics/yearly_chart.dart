import 'package:flutter/material.dart';
import 'package:flutter_money_mangement_application/Screens/Statics/monthly_chart.dart';
import 'package:flutter_money_mangement_application/Widgets/periad_bar.dart';
import 'package:flutter_money_mangement_application/controller/yearly_chart_controller.dart';
import 'package:get/get.dart';


class YearlyChart extends StatefulWidget {
  const YearlyChart({Key? key}) : super(key: key);

  @override
  State<YearlyChart> createState() => _YearlyChartState();
}

class _YearlyChartState extends State<YearlyChart> {
  final YearlyChartContoller chartController = Get.find();
  String period = '';
  int filterType = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    period = chartController.getPeriod();
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: PeriodBar(
            title: period,
            onPrevPress: () {
              chartController.prev();
              setState(() {
                period = chartController.getPeriod();
              });
            },
            onNextPress: () {
              chartController.next();
              setState(() {
                period = chartController.getPeriod();
              });
            },
          ),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GetBuilder<YearlyChartContoller>(
              builder: (controller) {
                return PieChartView(
                  controller: controller,
                );
              },
            ))
      ],
    );
  }
}