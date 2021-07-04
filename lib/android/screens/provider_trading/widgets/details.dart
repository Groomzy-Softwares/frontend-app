import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Details extends StatelessWidget {
  final List dayTimes;
  final List staffs;
  final Map address;

  const Details({
    this.staffs,
    this.dayTimes,
    this.address,
    Key key,
  }) : super(key: key);

  Widget mapContainer({
    BuildContext context,
    String address,
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
              markerId: MarkerId(address),
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
    return Column(
      children: [
        mapContainer(
          context: context,
          address: address['address'] ?? '',
          lat: address['latitude'] ?? 0,
          log: address['longitude'] ?? 0,
        ),
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
        SizedBox(
          height: 10.0,
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
            if (staffs.length > 0)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    ...staffs
                        .map(
                          (staff) => Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.black12,
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      staff['fullName']
                                          .toString()
                                          .split(' ')[0][0]
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(staff['fullName'].toString().split(' ')[0]),
                            ],
                          ),
                        )
                        .toList()
                  ],
                ),
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
        SizedBox(
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              ...dayTimes
                  .map(
                    (dayTime) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dayTime['day']['day'],
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              '${dayTime['time']['startTime']} -'
                              ' ${dayTime['time']['endTime']}',
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
