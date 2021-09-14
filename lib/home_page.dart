import 'package:flutter/material.dart';
import 'package:flutter_permission/model/permission_model.dart';
import 'package:permission_handler/permission_handler.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _fileSystemPermission = false;
  bool _locationPermission = false;
  bool _bluetoothPermission = false;
  bool _cameraPermission = false;
  bool _smsPermission = false;
  bool _voiceInputPermission = false;
  bool _notificationsPermission = false;

  @override
  void initState() {
    requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PermissionModel> list = [
      PermissionModel(_fileSystemPermission, 'File System'),
      PermissionModel(_cameraPermission, 'Camera'),
      PermissionModel(_locationPermission, 'Location'),
      PermissionModel(_bluetoothPermission, 'Bluetooth'),
      PermissionModel(_smsPermission, 'Sms'),
      PermissionModel(_voiceInputPermission, 'Voice Input'),
      PermissionModel(_notificationsPermission, 'Notifications'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test App'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.lightBlue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Center(child: Text('Permissions Allowed:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),),),
            const SizedBox(height: 20,),
            for(int i =0 ; i< list.length; i++)
              PermissionCard(isPermitted: list[i].isPermitted, title: list[i].title),
          ],
        ),
      ),
    );
  }

  Future<void> requestPermissions() async {
    _cameraPermission = await Permission.camera.request().isGranted;
    _locationPermission = await Permission.location.request().isGranted;
    _fileSystemPermission = await Permission.storage.request().isGranted;
    _bluetoothPermission = await Permission.bluetooth.request().isGranted;
    _smsPermission = await Permission.sms.request().isGranted;
    _voiceInputPermission = await Permission.speech.request().isGranted;
    _notificationsPermission =
        await Permission.notification.request().isGranted;
    setState(() {});
  }
}

class PermissionCard extends StatelessWidget {
  final bool isPermitted;
  final String title;
  const PermissionCard(
      {Key? key, required this.isPermitted, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(children: [
        (isPermitted)
            ? const Icon(
                Icons.done,
                color: Colors.green,
                size: 25,
              )
            : const Icon(
                Icons.clear,
                color: Colors.red,
                size: 25,
              ),
        const SizedBox(width: 15,),
        Text(title, style: const TextStyle(fontSize: 18),),
      ]),
    );
  }
}