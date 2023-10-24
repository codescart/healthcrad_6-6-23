import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:healthcrad_user/Locale/locale.dart';
import 'package:healthcrad_user/OrderMapBloc/order_map_bloc.dart';
import 'package:healthcrad_user/OrderMapBloc/order_map_state.dart';
import 'package:healthcrad_user/Theme/colors.dart';
import 'package:healthcrad_user/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:healthcrad_user/Routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderMapBloc>(
      create: (context) => OrderMapBloc()..loadMap(),
      child: OrderTrackingBody(),
    );
  }
}


class OrderTrackingBody extends StatefulWidget {
  @override
  _OrderTrackingBodyState createState() => _OrderTrackingBodyState();
}

class _OrderTrackingBodyState extends State<OrderTrackingBody> {
  Completer<GoogleMapController> _mapController = Completer();
  GoogleMapController? mapStyleController;
  Set<Marker> _markers = {};

  @override
  void initState() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.chevron_left)),
        title: Text(
          locale.orderTrack!,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: FadedSlideAnimation(
        Column(
          children: [
            // Expanded(
            //   child: Image.asset(
            //     'assets/map1.png',
            //     width: MediaQuery.of(context).size.width,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Expanded(
              child: BlocBuilder<OrderMapBloc, OrderMapState>(
                  builder: (context, state) {
                    print('polyyyy' + state.polylines.toString());
                    return GoogleMap(
                      polylines: state.polylines,
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex,
                      markers: _markers,
                      onMapCreated: (GoogleMapController controller) async {
                        _mapController.complete(controller);
                        mapStyleController = controller;
                        mapStyleController!.setMapStyle(mapStyle);
                        setState(() {
                          _markers.add(
                            Marker(
                              markerId: MarkerId('mark1'),
                              position:
                              LatLng(37.42796133580664, -122.085749655962),
                              icon: markerss.first,
                            ),
                          );
                          _markers.add(
                            Marker(
                              markerId: MarkerId('mark2'),
                              position:
                              LatLng(37.42496133180663, -122.081743655960),
                              icon: markerss[1],
                            ),
                          );
                          // _markers.add(
                          //   Marker(
                          //     markerId: MarkerId('mark3'),
                          //     position:
                          //     LatLng(37.42196183580660, -122.089743655967),
                          //     icon: markerss[2],
                          //   ),
                          // );
                        });
                      },
                    );
                  }),
            ),
            ListTile(
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/ProfilePics/dp5.png'),
                  ),
                ),
              ),
              title: Text('Harsh Singh',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: black2)),
              subtitle: Text(locale.deliveryPartner!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 11.7, color: Color(0xffb3b3b3))),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).dividerColor,
                      ),
                      onPressed: () {},
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.phone, size: 19, color: kMainColor),
                      ),
                      label: Text(
                        locale.call!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: kMainColor, fontSize: 16.7),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 48,
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, PageRoutes.chatWithDelivery);
                      },
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.chat,
                          size: 19,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                      label: Text(
                        locale.chat!,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16.7),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: kMainColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
