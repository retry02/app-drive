import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/DriverRatingTripContent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/bloc/DriverRatingTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/bloc/DriverRatingTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class DriverRatingTripPage extends StatefulWidget {
  const DriverRatingTripPage({super.key});

  @override
  State<DriverRatingTripPage> createState() => _DriverRatingTripPageState();
}

class _DriverRatingTripPageState extends State<DriverRatingTripPage> {
  ClientRequestResponse? clientRequestResponse;
  @override
  Widget build(BuildContext context) {
    clientRequestResponse =
        ModalRoute.of(context)?.settings.arguments as ClientRequestResponse;
    return Scaffold(
      body: BlocListener<DriverRatingTripBloc, DriverRatingTripState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          else if (response is Success) {
            Navigator.pushNamedAndRemoveUntil(context, 'driver/home', (route) => false);
          }
        },
        child: BlocBuilder<DriverRatingTripBloc, DriverRatingTripState>(
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
                child: DriverRatingTripContent(state, clientRequestResponse));
          },
        ),
      ),
    );
  }
}
