import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/ClientMapTripContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripState.dart';

class ClientMapTripPage extends StatefulWidget {
  const ClientMapTripPage({super.key});

  @override
  State<ClientMapTripPage> createState() => _ClientMapTripPageState();
}

class _ClientMapTripPageState extends State<ClientMapTripPage> {
  int? idClientRequest;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<ClientMapTripBloc>().add(InitClientMapTripEvent());
        context.read<ClientMapTripBloc>().add(GetClientRequest(idClientRequest: idClientRequest!));
        context.read<ClientMapTripBloc>().add(ListenTripNewDriverPosition());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<ClientMapTripBloc, ClientMapTripState>(
        listener: (context, state) {
          final responseClientRequest = state.responseGetClientRequest;
          
          if (responseClientRequest is Success) {
            final data = responseClientRequest.data as ClientRequestResponse;
            
          }
          else if (responseClientRequest is ErrorData) {
            Fluttertoast.showToast(msg: responseClientRequest.message, toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<ClientMapTripBloc, ClientMapTripState>(
          builder: (context, state) {
            final responseClientRequest = state.responseGetClientRequest;
            if (responseClientRequest is Success) {
              final data = responseClientRequest.data as ClientRequestResponse;
              
              return ClientMapTripContent(state, data);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
