import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/DriverMapTripContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripState.dart';

class DriverMapTripPage extends StatefulWidget {
  const DriverMapTripPage({super.key});

  @override
  State<DriverMapTripPage> createState() => _DriverMapTripPageState();
}

class _DriverMapTripPageState extends State<DriverMapTripPage> {

  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<DriverMapTripBloc>().add(InitDriverMapTripEvent());
        context.read<DriverMapTripBloc>().add(GetClientRequest(idClientRequest: idClientRequest!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<DriverMapTripBloc, DriverMapTripState>(
        listener: (context, state) {
          final responseClientRequest = state.responseGetClientRequest;
          if (responseClientRequest is Success) {
            final data = responseClientRequest.data as ClientRequestResponse;
          }
          else if (responseClientRequest is ErrorData) {
            Fluttertoast.showToast(msg: responseClientRequest.message, toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<DriverMapTripBloc, DriverMapTripState>(
          builder: (context, state) {
            final responseClientRequest = state.responseGetClientRequest;
            if (responseClientRequest is Success) {
              final data = responseClientRequest.data as ClientRequestResponse;
              return DriverMapTripContent(state, data, null);
            }
            return Container();
          },
        ),
      ),
    );
  }
}