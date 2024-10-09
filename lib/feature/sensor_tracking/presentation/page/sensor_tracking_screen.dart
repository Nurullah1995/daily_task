import 'package:flutter_project/feature/sensor_tracking/data/model/sensor_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

class SensorTrackingScreen extends StatefulWidget {
  const SensorTrackingScreen({super.key});

  @override
  State<SensorTrackingScreen> createState() => _SensorTrackingScreenState();
}

class _SensorTrackingScreenState extends State<SensorTrackingScreen> {
  late List<SensorData> accelerometerData;
  late List<SensorData> gyroscopeData;
  late ChartSeriesController _accelerometerController;
  late ChartSeriesController _gyroscopeController;
  int time = 0;

  @override
  void initState() {
    accelerometerData = <SensorData>[];
    gyroscopeData = <SensorData>[];
    super.initState();
    initSensors();
  }

  void initSensors() {
    // Listen to accelerometer data
    accelerometerEvents.listen((AccelerometerEvent event) {
      updateAccelerometerData(event.x, event.y, event.z);
    });

    // Listen to gyroscope data
    gyroscopeEvents.listen((GyroscopeEvent event) {
      updateGyroscopeData(event.x, event.y, event.z);
    });
  }

  void updateAccelerometerData(double x, double y, double z) {
    print("Accelerometer Data - X: $x, Y: $y, Z: $z");
    setState(() {
      accelerometerData.add(SensorData(time++, x, y, z));
      if (accelerometerData.length > 20) {
        accelerometerData.removeAt(0);
      }
      _accelerometerController.updateDataSource(
        addedDataIndex: accelerometerData.length - 1,
        removedDataIndex: 0,
      );
    });
  }

  void updateGyroscopeData(double x, double y, double z) {
    print("Gyroscope Data - X: $x, Y: $y, Z: $z");
    setState(() {
      gyroscopeData.add(SensorData(time++, x, y, z));
      if (gyroscopeData.length > 20) {
        gyroscopeData.removeAt(0);
      }
      _gyroscopeController.updateDataSource(
        addedDataIndex: gyroscopeData.length - 1,
        removedDataIndex: 0,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            // Accelerometer Data Chart
            Expanded(
              child: _buildGyroScopeChart(),
            ),
            Expanded(
              child: _buildAccelerometerChart(),
            ),
            // Gyroscope Data Chart
          ],
        ),
      ),
    );
  }

  _buildGyroScopeChart(){
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Gyro',style: TextStyle(fontSize: 20),),
              ),
              const Divider(),
              Expanded(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Meeting',textStyle: const TextStyle(fontSize: 10)),
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _gyroscopeController = controller;
                      },
                      dataSource: gyroscopeData,
                      color: Colors.red,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X-Axis',
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroscopeData,
                      color: Colors.green,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y-Axis',
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroscopeData,
                      color: Colors.blue,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z-Axis',
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Gyroscope sensor data (rad/s)',textStyle: const TextStyle(fontSize: 10),),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Walking',textStyle: const TextStyle(fontSize: 10),),
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _gyroscopeController = controller;
                      },
                      dataSource: gyroscopeData,
                      color: Colors.red,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X-Axis',
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroscopeData,
                      color: Colors.green,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y-Axis',
                    ),
                    LineSeries<SensorData, int>(
                      dataSource: gyroscopeData,
                      color: Colors.blue,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z-Axis',
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                    title: AxisTitle(text: 'Gyroscope sensor data (rad/s)',textStyle: const TextStyle(fontSize: 10)),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
  _buildAccelerometerChart(){
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20,),
                child: Text('Accelerometer Sensor Data',style: TextStyle(fontSize: 20),),
              ),
              const Divider(),
              Expanded(
                child: SfCartesianChart(
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _accelerometerController = controller;
                      },
                      dataSource: accelerometerData,
                      color: Colors.red,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.x,
                      name: 'X-Axis',
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child:SfCartesianChart(
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerData,
                      color: Colors.green,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.y,
                      name: 'Y-Axis',
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Expanded(
                child: SfCartesianChart(
                  series: <LineSeries<SensorData, int>>[
                    LineSeries<SensorData, int>(
                      dataSource: accelerometerData,
                      color: Colors.blue,
                      xValueMapper: (SensorData data, _) => data.time,
                      yValueMapper: (SensorData data, _) => data.z,
                      name: 'Z-Axis',
                    ),
                  ],
                  primaryXAxis: NumericAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    interval: 3,
                  ),
                  primaryYAxis: NumericAxis(
                    axisLine: const AxisLine(width: 0),
                    majorTickLines: const MajorTickLines(size: 0),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
