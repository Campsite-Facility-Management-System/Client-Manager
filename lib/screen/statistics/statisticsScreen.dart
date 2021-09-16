import 'package:client_manager/getX/stController/stController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'indicator.dart';

class StatisticsScreen extends StatelessWidget {
  final stController = Get.put(StController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
              color: Colors.white),
          centerTitle: true,
          title: Text(
            '통계',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Text(
                  '<전력 총사용량>',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                stController.electric == null
                    ? Center(child: CircularProgressIndicator())
                    : AspectRatio(
                        aspectRatio: 1.5,
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 40, bottom: 20),
                          child: GetBuilder<StController>(
                            builder: (_) {
                              return LineChart(
                                LineChartData(
                                  gridData: FlGridData(
                                    show: false,
                                    drawVerticalLine: true,
                                    getDrawingHorizontalLine: (value) {
                                      return FlLine(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return FlLine(
                                        color: Colors.white,
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    rightTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                    topTitles: SideTitles(
                                      showTitles: false,
                                    ),
                                    leftTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 50,
                                      margin: 2,
                                      interval: 1,
                                      getTitles: (value) {
                                        if (value.toInt() == 0) {
                                          return '0w';
                                        }

                                        if (value.toInt() ==
                                            stController.max.value.toInt()) {
                                          return stController.max.value
                                                  .toString() +
                                              'w';
                                        }

                                        return '';
                                      },
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: Border.all(
                                        color: Colors.green, width: 1),
                                  ),
                                  minX: 0,
                                  maxX: 13,
                                  minY: -2,
                                  maxY: stController.max.value < 100
                                      ? 100
                                      : stController.max.value * 1.2,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: stController.electric,
                                      isCurved: false,
                                      barWidth: 5,
                                      dotData: FlDotData(
                                        show: true,
                                      ),
                                      belowBarData: BarAreaData(
                                        show: false,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                SizedBox(height: 10),
                Text(
                  '<물품 인기도>',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: GetBuilder<StController>(builder: (_) {
                      return AspectRatio(
                        aspectRatio: 1.3,
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                height: 18,
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {}),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showingGoodsSections()),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Indicator(
                                    color: Color(0xff0293ee),
                                    text: '1위 물품',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xfff8b250),
                                    text: '2위 물품',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff845bef),
                                    text: '3위 물품',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff13d38e),
                                    text: '기타 물품',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
                SizedBox(height: 10),
                Text(
                  '<카테고리 인기도>',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: GetBuilder<StController>(builder: (_) {
                      return AspectRatio(
                        aspectRatio: 1.3,
                        child: Card(
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              const SizedBox(
                                height: 18,
                              ),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PieChart(
                                    PieChartData(
                                        pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {}),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 0,
                                        centerSpaceRadius: 40,
                                        sections: showingSections()),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Indicator(
                                    color: Color(0xff0293ee),
                                    text: '1위 카테고리',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xfff8b250),
                                    text: '2위 카테고리',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff845bef),
                                    text: '3위 카테고리',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Indicator(
                                    color: Color(0xff13d38e),
                                    text: '기타 카테고리',
                                    isSquare: true,
                                  ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 28,
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              ],
            ),
          ),
        ));
  }

  List<PieChartSectionData> showingGoodsSections() {
    return List.generate(4, (i) {
      // final isTouched = i == touchedIndex;
      final fontSize = 15.0;
      final radius = 60.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 50,
            title: '50%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 20,
            title: '20%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d222),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      // final isTouched = i == touchedIndex;
      final fontSize = 15.0;
      final radius = 60.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d222),
            value: 10,
            title: '10%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );

        default:
          throw Error();
      }
    });
  }
}
