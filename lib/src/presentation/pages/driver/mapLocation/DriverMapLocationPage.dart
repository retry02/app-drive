import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIOEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';
import 'package:toggle_switch/toggle_switch.dart';


class DriverMapLocationPage extends StatefulWidget {
  const DriverMapLocationPage({super.key});

  @override
  State<DriverMapLocationPage> createState() => _DriverMapLocationPageState();
}

class _DriverMapLocationPageState extends State<DriverMapLocationPage> {
  

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      context.read<DriverMapLocationBloc>().add(DriverMapLocationInitEvent());
      context.read<DriverMapLocationBloc>().add(FindPosition());
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<DriverMapLocationBloc, DriverMapLocationState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle('[ { "featureType": "all", "elementType": "labels.text.fill", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "all", "elementType": "labels.text.stroke", "stylers": [ { "color": "#000000" }, { "lightness": 13 } ] }, { "featureType": "administrative", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "administrative", "elementType": "geometry.stroke", "stylers": [ { "color": "#144b53" }, { "lightness": 14 }, { "weight": 1.4 } ] }, { "featureType": "landscape", "elementType": "all", "stylers": [ { "color": "#08304b" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#0c4152" }, { "lightness": 5 } ] }, { "featureType": "road.highway", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.highway", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b434f" }, { "lightness": 25 } ] }, { "featureType": "road.arterial", "elementType": "geometry.fill", "stylers": [ { "color": "#000000" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#0b3d51" }, { "lightness": 16 } ] }, { "featureType": "road.local", "elementType": "geometry", "stylers": [ { "color": "#000000" } ] }, { "featureType": "transit", "elementType": "all", "stylers": [ { "color": "#146474" } ] }, { "featureType": "water", "elementType": "all", "stylers": [ { "color": "#021019" } ] } ]');
                  if (!state.controller!.isCompleted) {
                    state.controller?.complete(controller); 
                  }
                },
              ),
              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 30),
                child: ToggleSwitch(
                  minWidth: 130.0,
                  minHeight: 50,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.yellow], [Colors.red]],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey[400],
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  customTextStyles: [ TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic) ],
                  labels: ['Conectado', 'Desconectado'],
                  radiusStyle: true,
                  onToggle: (index) {
                    if (index == 0) { //CONECTADO
                      context.read<BlocSocketIO>().add(ConnectSocketIO());
                      context.read<DriverMapLocationBloc>().add(FindPosition());
                    }
                    else if (index == 1) { // DESCONECTADO
                      context.read<BlocSocketIO>().add(DisconnectSocketIO());
                      context.read<DriverMapLocationBloc>().add(StopLocation());
                    }
                    print('switched to: $index');
                  },
                ),
              )
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   child: DefaultButton(
              //     text: 'DETENER LOCALIZACION', 
              //     margin: EdgeInsets.only(left: 50, right: 50, bottom: 50),
              //     onPressed: () {
              //       context.read<BlocSocketIO>().add(DisconnectSocketIO());
              //       context.read<DriverMapLocationBloc>().add(StopLocation());
              //     }
              //   ),
              // )
            ],
          );
        },
      ),
    );
  }

}
