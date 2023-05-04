

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trust_location/trust_location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? latitude;
  String? longitude;
  bool? isMock;
  bool showText = false;

  @override
  void initState(){
  
    requestPermission();
     super.initState();
  }

  void requestPermission() async{
    final permission = await Permission.location.request();

    if(permission == PermissionStatus.granted){
      TrustLocation.start(10);
      getLocation();
    }else if(permission == PermissionStatus.denied){
      await Permission.location.request();

    }
  }
  void getLocation() async{
    try{
      TrustLocation.onChange.listen((result) { 
        setState(() {
          latitude = result.latitude;
          longitude = result.longitude;
          isMock = result.isMockLocation;
          showText = true;
        });
        geoCode();
      }
      );
    }
    catch(e){
      print("error");
    }
  }
void geoCode() async{
     //List<Placemark> placemark = await placemarkFromCoordinates(double.parse(latitude!),double.parse( longitude!));

//print(placemark[0].country);
//print(placemark[0].street);

}

@override
  void dispose(){
    TrustLocation.stop();
    super.dispose();
  

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
           showText ? "Lat : $latitude\nLong : $longitude\nMock location : $isMock" :"",
            // Text
           // Center
         // Scaffold
  ),
  ),
  );
  }
}
