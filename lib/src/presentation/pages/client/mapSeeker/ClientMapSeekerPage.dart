import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultActionText.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/GooglePlacesAutoComplete.dart';

class ClientMapSeekerPage extends StatefulWidget {
  const ClientMapSeekerPage({super.key});

  @override
  State<ClientMapSeekerPage> createState() => _ClientMapSeekerPageState();
}

class _ClientMapSeekerPageState extends State<ClientMapSeekerPage> {
 
  TextEditingController pickUpController = TextEditingController();
  TextEditingController destinationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      context.read<ClientMapSeekerBloc>().add(ClientMapSeekerInitEvent());
      context.read<ClientMapSeekerBloc>().add(ListenDriversPositionSocketIO());
      context.read<ClientMapSeekerBloc>().add(ListenDriversDisconnectedSocketIO());
      context.read<ClientMapSeekerBloc>().add(FindPosition());
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<ClientMapSeekerBloc, ClientMapSeekerState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onCameraMove: (CameraPosition cameraPosition) {
                  context.read<ClientMapSeekerBloc>().add(OnCameraMove(cameraPosition: cameraPosition));
                },
                onCameraIdle: () async {
                  context.read<ClientMapSeekerBloc>().add(OnCameraIdle());
                  pickUpController.text = state.placemarkData?.address ?? '';
                  if (state.placemarkData != null) {
                    context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                      lat: state.placemarkData!.lat, 
                      lng: state.placemarkData!.lng,
                      pickUpDescription: state.placemarkData!.address
                    ));
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller); 
                    }
                  }
                  
                },
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                child: _googlePlacesAutocomplete()
              ),
              _iconMyLocation(),
              Container(
                alignment: Alignment.bottomCenter,
                child: DefaultButton(
                  margin: EdgeInsets.only(bottom: 30, left: 60, right: 60),
                  text: 'REVISAR VIAJE', 
                  iconData: Icons.check_circle,
                  // textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(
                      context, 
                      'client/map/booking',
                      arguments: {
                        'pickUpLatLng': state.pickUpLatLng,
                        'destinationLatLng': state.destinationLatLng,
                        'pickUpDescription': state.pickUpDescription,
                        'destinationDescription': state.destinationDescription,
                      }
                    );
                  }
                )
              )
            ],
          );
        },
      ),
    );
  }

  Widget _googlePlacesAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          GooglePlacesAutoComplete(
            pickUpController, 
            'Recoger en', 
            (Prediction prediction) {
              if (prediction != null) {
                context.read<ClientMapSeekerBloc>().add(ChangeMapCameraPosition(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                ));
                context.read<ClientMapSeekerBloc>().add(OnAutoCompletedPickUpSelected(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                  pickUpDescription: prediction.description ?? ''
                ));
              }
            }
          ),
          Divider(
            color: Colors.grey[200],
          ),
          GooglePlacesAutoComplete(
            destinationController, 
            'Dejar en', 
            (Prediction prediction) {
              context.read<ClientMapSeekerBloc>().add(OnAutoCompletedDestinationSelected(
                lat: double.parse(prediction.lat!), 
                lng: double.parse(prediction.lng!),
                destinationDescription: prediction.description ?? ''
              ));
            }
          )
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/img/location_blue.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
