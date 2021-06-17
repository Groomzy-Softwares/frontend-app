import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/horizontal_scroll/staffers.dart';

class Details extends StatelessWidget {
  const Details({Key key}) : super(key: key);

  Widget mapContainer({
    BuildContext context,
    String address,
    int providerId,
    double lat,
    double log,
  }) {
    return Container(
      height: 200,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, log),
          zoom: 17,
        ),
        markers: Set.from(
          [
            Marker(
              infoWindow: InfoWindow(title: address),
              markerId: MarkerId('$providerId'),
              draggable: false,
              position: LatLng(lat, log),
            )
          ],
        ),
      ),
    );
  }

  Widget tableHeader(String heading, BuildContext context) {
    return TableCell(
      child: Container(
        child: Text(
          heading,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String address = '83 Ntonto Zulu Dr, Umlazi, Umlazi D, Durban, 4031';
    final int providerId = 1;
    final List<String> staffs = ['Sifiso', 'Myeza'];
    final List businessDays = ['Mon', 'Tue', 'Wed'];
    final String businessStartTime = '07:00 am';
    final String businessEndTime = '06:00 pm';
    final double lat = 26.3008;
    final double log = 27.9483;

    return Column(
      children: [
        mapContainer(
            context: context,
            address: address,
            providerId: providerId,
            lat: lat,
            log: log),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Staffers',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Column(
          children: [
            if (staffs.length <= 0)
              Container(
                margin: EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'There are no staff yet.',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              ),
            AndroidStaffers(
              onSelectStaffer: (selectedStaffer) {
                print(selectedStaffer);
              },
            ),
          ],
        ),
        Divider(),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'Operating day times',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0,),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              ...businessDays.map((day) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        day,
                        style: TextStyle(color: Colors.black54),
                      ),
                      Text('$businessStartTime - $businessEndTime'),
                    ],
                  ),
                  Divider(),
                ],
              )).toList(),
            ],
          ),
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }
}
