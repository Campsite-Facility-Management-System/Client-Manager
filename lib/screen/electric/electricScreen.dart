import 'package:client_manager/getX/electric/electricGraphGetX.dart';
import 'package:client_manager/getX/electric/electricListGetX.dart';
import 'package:client_manager/getX/token/tokenGetX.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectricInfoScreen extends StatelessWidget {
  var data;
  ElectricInfoScreen(this.data);

  @override
  Widget build(BuildContext context) {
    final graph_Controller = Get.put(ElectricGraphGetX());
    final tokenController = Get.put(TokenGetX());
    final electricController = Get.put(ElectricInfoGetX());

    graph_Controller.apiDeviceState();

    // graph_Controller.apiDeviceStatus();
    graph_Controller.deviceId.value = this.data['id'].toString();
    graph_Controller.apiUsageData();
    graph_Controller.apiGraph();
    graph_Controller.loop();

    return WillPopScope(
      onWillPop: () {
        electricController.apiElectricCategoryList();
        Get.back();
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.green,
          title: Text('기기정보'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 40, right: 70, top: 10, bottom: 10),
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.white),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  data['name'] != null
                                      ? data['name']
                                      : 'loading',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => Container(
                            child: Transform.scale(
                              scale: 4.0,
                              child: Switch(
                                value: graph_Controller.isSwitched.value,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.lightGreen,
                                onChanged: (value) {
                                  graph_Controller.apichangeStatus(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.electrical_services_outlined),
                                  SizedBox(width: 5),
                                  Text(
                                    '사용량',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => Text(
                                  graph_Controller.usage.value != null
                                      ? graph_Controller.usage.value
                                              .toString() +
                                          "kW"
                                      : 'loading...',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10, right: 20, top: 10, bottom: 10),
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.5, color: Colors.grey),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.money_rounded),
                                  SizedBox(width: 5),
                                  Text(
                                    '예상요금',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Obx(
                                () => Text(
                                  graph_Controller.charge.value != null
                                      ? graph_Controller.charge.toString() + "원"
                                      : 'loading...',
                                  style: TextStyle(fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              graph_Controller.spotList == null
                  ? Center(child: CircularProgressIndicator())
                  : AspectRatio(
                      aspectRatio: 1.5,
                      child: Container(
                        margin:
                            EdgeInsets.only(left: 10, right: 40, bottom: 20),
                        child: GetBuilder<ElectricGraphGetX>(
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
                                          graph_Controller.max.value.toInt()) {
                                        return graph_Controller.max.value
                                                .toString() +
                                            'w';
                                      }

                                      return '';
                                    },
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border:
                                      Border.all(color: Colors.green, width: 1),
                                ),
                                minX: 0,
                                maxX: 13,
                                minY: -2,
                                maxY: graph_Controller.max.value < 100
                                    ? 100
                                    : graph_Controller.max.value * 1.2,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: graph_Controller.spotList,
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
            ],
          ),
        ),
      ),
    );
  }
}
