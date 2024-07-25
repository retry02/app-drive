import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/ClientDriverOffersItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersState.dart';
import 'package:lottie/lottie.dart';

class ClientDriverOffersPage extends StatefulWidget {
  const ClientDriverOffersPage({super.key});

  @override
  State<ClientDriverOffersPage> createState() => _ClientDriverOffersPageState();
}

class _ClientDriverOffersPageState extends State<ClientDriverOffersPage> {

  int? idClientRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (idClientRequest != null) {
        context.read<ClientDriverOffersBloc>().add(ListenNewDriverOfferSocketIO(idClientRequest: idClientRequest!));
      }      
    });
  }

  @override
  Widget build(BuildContext context) {
    idClientRequest = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      body: BlocListener<ClientDriverOffersBloc, ClientDriverOffersState>(
        listener: (context, state) {
          final response = state.responseDriverOffers;
          final responseAssignDriver = state.responseAssignDriver;
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG);
          }
          if (responseAssignDriver is Success) {
            Navigator.pushNamed(context, 'client/map/trip', arguments: idClientRequest);
          }
        },
        child: BlocBuilder<ClientDriverOffersBloc, ClientDriverOffersState>(
            builder: (context, state) {
          final response = state.responseDriverOffers;

          if (response is Loading) {
            return Center(child: CircularProgressIndicator());
          } 
          else if (response is Success) {
            List<DriverTripRequest> driverTripRequest = response.data as List<DriverTripRequest>;
            return ListView.builder(
                itemCount: driverTripRequest.length,
                itemBuilder: (context, index) {
                  if (driverTripRequest.length == 0) {
                    return Column(
                      children: [
                        Text('Esperando conductores...'),
                        Lottie.asset(
                          'assets/lottie/waiting_car.json',
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        )
                      ],
                    );
                  }
                  return ClientDriverOffersItem(driverTripRequest[index]);
                });
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Esperando conductores...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Lottie.asset(
                  'assets/lottie/waiting_car.json',
                  width: 400,
                  height: 230,
                  // fit: BoxFit.fill,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
