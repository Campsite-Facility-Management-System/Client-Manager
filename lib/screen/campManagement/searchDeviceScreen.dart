import 'dart:async';
import 'dart:typed_data';

import 'package:client_manager/getX/campManagement/setDeviceGetX.dart';
import 'package:client_manager/container/campManagement/bluetoothList.dart';
import 'package:client_manager/screen/campManagement/setDeviceWifiScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:android_intent/android_intent.dart';

class SearchDeviceScreen extends StatefulWidget {
  final bool start;
  const SearchDeviceScreen({this.start = true});

  @override
  SearchDeviceScreenState createState() => SearchDeviceScreenState();
}

class SearchDeviceScreenState extends State<SearchDeviceScreen> {
  StreamSubscription<BluetoothDiscoveryResult> streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();
  bool isDiscovering;
  BluetoothConnection connection;
  SearchDeviceScreenState();

  @override
  void initState() {
    super.initState();

    // Location.instance.serviceEnabled();

    //위치 설정 진입
    _locationOn();
    //블루투스 ON
    BluetoothEnable.enableBluetooth;

    // _checkPermissions();
    isDiscovering = widget.start;
    if (isDiscovering) {
      _startDiscovery();
    }
  }

  //위치 설정 진입
  _locationOn() async {
    final AndroidIntent intent = new AndroidIntent(
      action: 'android.settings.LOCATION_SOURCE_SETTINGS',
    );
    await intent.launch();
  }

  // _checkPermissions() async {
  //   if (Platform.isAndroid) {
  //     if (await Permission.contacts.request().isGranted) {}
  //     Map<Permission, PermissionStatus> statuses =
  //         await [Permission.location].request();
  //     print(statuses[Permission.location]);
  //   }
  // }

  void _restartDiscovery() {
    setState(() {
      results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  _startDiscovery() async {
    print("검색 시작");
    var name = [];
    streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        if (r.device.name != null) {
          print('r: ' + r.device.name.toString());
          if (!name.contains(r.device.name)) {
            name.add(r.device.name);
            results.add(r);
          }
        }
      });
    });

    print(streamSubscription);

    streamSubscription.onDone(
      () {
        setState(() {
          isDiscovering = false;
        });
      },
    );
  }

  Future send(Uint8List data) async {
    connection.output.add(data);
    await connection.output.allSent;
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and cancel discovery
    print("검색 종료");
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SetDeviceGetX());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: isDiscovering ? Text('디바이스 검색중...') : Text('디바이스 검색완료'),
        actions: <Widget>[
          isDiscovering
              ? FittedBox(
                  child: Container(
                    margin: new EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.replay),
                  onPressed: _restartDiscovery,
                )
        ],
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (BuildContext context, index) {
          BluetoothDiscoveryResult result = results[index];
          return BluetoothList(
            device: result.device,
            rssi: result.rssi,
            onTap: () {
              controller.connect(result.device.address);
              Get.off(() => SetDeviceWifiScreen(result.device.address));
            },
            onLongPress: () async {
              try {
                bool bonded = false;
                if (result.device.isBonded) {
                  print('Unbonding from ${result.device.address}...');
                  await FlutterBluetoothSerial.instance
                      .removeDeviceBondWithAddress(result.device.address);
                  print('Unbonding from ${result.device.address} has succed');
                } else {
                  print('Bonding with ${result.device.address}...');
                  bonded = await FlutterBluetoothSerial.instance
                      .bondDeviceAtAddress(result.device.address);
                  print(
                      'Bonding with ${result.device.address} has ${bonded ? 'succed' : 'failed'}.');
                }
                setState(() {
                  results[results.indexOf(result)] = BluetoothDiscoveryResult(
                      device: BluetoothDevice(
                        name: result.device.name ?? '',
                        address: result.device.address,
                        type: result.device.type,
                        bondState: bonded
                            ? BluetoothBondState.bonded
                            : BluetoothBondState.none,
                      ),
                      rssi: result.rssi);
                });
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text("${ex.toString()}"),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
