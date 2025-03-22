import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
late List<CameraDescription> _cameras;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _cameras=await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 late CameraController _cameraController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController=CameraController(_cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          print('Camera Access Denied!');
            break;
          default:
             print('Camera Exception');
            break;
        }
      }
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         body: CameraPreview(_cameraController),
      ),
    );
  }
}
