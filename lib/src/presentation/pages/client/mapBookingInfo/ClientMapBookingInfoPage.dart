import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/src/domain/models/TimeAndDistanceValues.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/ClientMapBookingInfoContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoState.dart';

class ClientMapBookingInfoPage extends StatefulWidget {
  const ClientMapBookingInfoPage({super.key});

  @override
  State<ClientMapBookingInfoPage> createState() =>
      _ClientMapBookingInfoPageState();
}

class _ClientMapBookingInfoPageState extends State<ClientMapBookingInfoPage> {
  LatLng? pickUpLatLng;
  LatLng? destinationLatLng;
  String? pickUpDestination;
  String? destinationDescription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<ClientMapBookingInfoBloc>()
          .add(ClientMapBookingInfoInitEvent(
            pickUpLatLng: pickUpLatLng!,
            destinationLatLng: destinationLatLng!,
            pickUpDescription: pickUpDestination!,
            destinationDescription: destinationDescription!,
          ));
      context.read<ClientMapBookingInfoBloc>().add(GetTimeAndDistanceValues());
      context.read<ClientMapBookingInfoBloc>().add(AddPolyline());
      context.read<ClientMapBookingInfoBloc>().add(ChangeMapCameraPosition(
          lat: pickUpLatLng!.latitude, lng: pickUpLatLng!.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    pickUpLatLng = arguments['pickUpLatLng'];
    destinationLatLng = arguments['destinationLatLng'];
    pickUpDestination = arguments['pickUpDescription'];
    destinationDescription = arguments['destinationDescription'];
    return Scaffold(
      body: BlocListener<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
        listener: (context, state) {
          final responseClientRequest = state.responseClientRequest;
          if (responseClientRequest is Success) {
            int idClientRequest = responseClientRequest.data;
            context.read<ClientMapBookingInfoBloc>().add(EmitNewClientRequestSocketIO(idClientRequest: idClientRequest));
            // Navigator.pushNamedAndRemoveUntil(context, 'client/driver/offers', (route) => false);
            Navigator.pushNamed(context, 'client/driver/offers', arguments: idClientRequest);
            Fluttertoast.showToast(msg: 'Solicitud enviada', toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<ClientMapBookingInfoBloc, ClientMapBookingInfoState>(
          builder: (context, state) {
            final responseTimeAndDistance = state.responseTimeAndDistance;
            if (responseTimeAndDistance is Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (responseTimeAndDistance is Success) {
              TimeAndDistanceValues timeAndDistanceValues =
                  responseTimeAndDistance.data as TimeAndDistanceValues;
              return ClientMapBookingInfoContent(state, timeAndDistanceValues);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
