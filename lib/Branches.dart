import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpro/Branch.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class Branches extends StatefulWidget {
  const Branches({Key? key}) : super(key: key);

  @override
  _BranchesState createState() => _BranchesState();
}


class _BranchesState extends State<Branches> {
  Set<Marker> _branchesList = {};
  Completer<GoogleMapController> _controller = Completer();

  void onComplete(GoogleMapController controller) {
    _controller.complete();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPoint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'فروشگاه',
          style: TextStyle(color: Colors.black45, fontFamily: "Vazir"),
        ),
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black45,
        ),
      ),
      body: GoogleMap(
        onMapCreated: onComplete,
        markers: _branchesList,
        initialCameraPosition:
            CameraPosition(target: LatLng(31.405340, 54.033687), zoom: 6),
      ),
    );
  }

  void fetchPoint() async {
    var url = Uri.parse("https://welearn.site/flutter/branches.json");
    Response response = await get(url);
    print(utf8.decode(response.bodyBytes));
    setState(() {
      var BranchJson = json.decode(utf8.decode(response.bodyBytes));
      for (var i in BranchJson) {
        var Branches = new Branch(i['shop_name'], i['id'], i['tel'], i['lat'],
            i['lng'], i['manager']);
        Marker marker = Marker(
            markerId: MarkerId(Branches.id.toString()),
            position: LatLng(Branches.lat, Branches.lng),
            infoWindow: InfoWindow(
                title: Branches.shop_name, snippet: Branches.manager));
        _branchesList.add(marker);
      }
    });
  }
}
