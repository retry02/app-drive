import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequest.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/DriverClientRequestsItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsState.dart';

class DriverClientRequestsPage extends StatefulWidget {
  const DriverClientRequestsPage({super.key});

  @override
  State<DriverClientRequestsPage> createState() =>
      _DriverClientRequestsPageState();
}

class _DriverClientRequestsPageState extends State<DriverClientRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverClientRequestsBloc>().add(InitDriverClientRequest());
      context.read<DriverClientRequestsBloc>().add(ListenNewClientRequestSocketIO());
      // context.read<DriverClientRequestsBloc>().add(GetNearbyTripRequest());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<DriverClientRequestsBloc, DriverClientRequestsState>(
        listener: (context, state) {
          final responseCreateTripRequest = state.responseCreateDriverTripRequest;
          if (responseCreateTripRequest is Success) {
            Fluttertoast.showToast(msg: 'La oferta se ha enviado correctamente', toastLength: Toast.LENGTH_LONG);
          }
          else if (responseCreateTripRequest is ErrorData) {
            Fluttertoast.showToast(msg: responseCreateTripRequest.message, toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<DriverClientRequestsBloc, DriverClientRequestsState>(
            builder: (context, state) {
          final response = state.response;
          if (response is Loading) {
            return Center(child: CircularProgressIndicator());
          } 
          else if (response is Success) {
            List<ClientRequestResponse> clientRequests =
                response.data as List<ClientRequestResponse>;
            return ListView.builder(
                itemCount: clientRequests.length,
                itemBuilder: (context, index) {
                  return DriverClientRequestsItem(state, clientRequests[index]);
                });
          }
          return Container();
        }),
      ),
    );
  }
}
