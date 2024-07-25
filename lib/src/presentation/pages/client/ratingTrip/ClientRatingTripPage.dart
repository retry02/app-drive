import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/ClientRatingTripContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripState.dart';

class ClientRatingTripPage extends StatefulWidget {
  const ClientRatingTripPage({super.key});

  @override
  State<ClientRatingTripPage> createState() => _ClientRatingTripPageState();
}

class _ClientRatingTripPageState extends State<ClientRatingTripPage> {
  ClientRequestResponse? clientRequestResponse;

  @override
  Widget build(BuildContext context) {
    clientRequestResponse = ModalRoute.of(context)?.settings.arguments as ClientRequestResponse;
    return Scaffold(
      body: BlocListener<ClientRatingTripBloc, ClientRatingTripState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            Navigator.pushNamedAndRemoveUntil(context, 'client/home', (route) => false);
          }
        },
        child: BlocBuilder<ClientRatingTripBloc, ClientRatingTripState>(
          builder: (context, state) {
            return Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Color.fromARGB(255, 12, 38, 145),
                      Color.fromARGB(255, 34, 156, 249),
                    ])),
                child: ClientRatingTripContent(state, clientRequestResponse));
          },
        ),
      ),
    );
  }
}