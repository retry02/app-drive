import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/models/StatusTrip.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultImageUrl.dart';

class DriverMapTripContent extends StatelessWidget {
  
  DriverMapTripState state;
  ClientRequestResponse? clientRequest;
  TimeAndDistanceValues? timeAndDistanceValues;

  DriverMapTripContent(this.state, this.clientRequest, this.timeAndDistanceValues);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context)
        ),
      ],
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.47,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 186, 186, 186),
          ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
            Text(
              'TU CLIENTE',
              style: TextStyle(
                fontSize: 17, 
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.blueAccent
              ),
            ),
           ListTile(
            title: Text(
              '${clientRequest?.client?.name} ${clientRequest?.client?.lastname}',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Text(
              'Tel: ${clientRequest?.client?.phone}',
              style: TextStyle(
                fontSize: 13
              ),
            ),
            trailing: DefaultImageUrl(
              url: clientRequest?.client?.image,
              width: 60,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'DATOS DEL VIAJE',
            style: TextStyle(
              fontSize: 17, 
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.blueAccent
            ),
          ),
          ListTile(
            title: Text(
              'Ubicaciones',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Desde: ${clientRequest?.pickupDescription}',
                  style: TextStyle(
                    fontSize: 13
                  ),
                ),
                Text(
                  'Hasta: ${clientRequest?.destinationDescription}',
                  style: TextStyle(
                    fontSize: 13
                  ),
                ),
              ],
            ),
            leading: Icon(Icons.location_on),
          ),
        
          ListTile(
            title: Text(
              'Valor del viaje',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Text(
              '\$${clientRequest?.fareAssigned}',
              style: TextStyle(
                fontSize: 17,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
              ),
            ),
            leading: Icon(Icons.money),
          ),
          state.statusTrip == StatusTrip.ARRIVED 
          ?
          _actionUpdateStatus(
            'FINALIZAR VIAJE',
            Icons.power_settings_new,
            () {
              context.read<DriverMapTripBloc>().add(UpdateStatusToFinished());
            }
          )
          : _actionUpdateStatus(
            'NOTIFICAR LLEGADA',
            Icons.check,
            () {
              context.read<DriverMapTripBloc>().add(UpdateStatusToArrived());
            }
          )
        ],
      )
    );
  }

  Widget _actionUpdateStatus(String option, IconData icon, Function() function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 0, top: 15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            option,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          leading: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 19, 58, 213),
                  Color.fromARGB(255, 65, 173, 255),
                ]
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition,
        markers: Set<Marker>.of(state.markers.values),
        polylines: Set<Polyline>.of(state.polylines.values),
        onMapCreated: (GoogleMapController controller) {
          controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
          if (state.controller != null) {
            if (!state.controller!.isCompleted) {
              state.controller?.complete(controller); 
            }
          }
        },
      ),
    );
  }
}