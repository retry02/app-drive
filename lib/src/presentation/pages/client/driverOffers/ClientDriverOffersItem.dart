import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/DriverTripRequest.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class ClientDriverOffersItem extends StatelessWidget {

  DriverTripRequest? driverTripRequest;

  ClientDriverOffersItem(this.driverTripRequest);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: _imageUser(),
            title: Text(
              '${driverTripRequest?.driver?.name ?? ''} ${driverTripRequest?.driver?.lastname ?? ''}'
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('5.0'),
                Text(driverTripRequest?.car?.brand ?? ''),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${driverTripRequest?.time} min',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  ),
                ),
                Text(
                  '${driverTripRequest?.distance} km',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blueAccent
                  )
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 15),
                child: Text(
                  '\$${driverTripRequest?.fareOffered}',
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              DefaultButton(
                text: 'Aceptar', 
                onPressed: () {
                  context.read<ClientDriverOffersBloc>().add(
                    AssignDriver(
                      idClientRequest: driverTripRequest!.idClientRequest, 
                      idDriver: driverTripRequest!.idDriver, 
                      fareAssigned: driverTripRequest!.fareOffered,
                      context: context
                    )
                  );
                },
                width: 120,
                height: 40,
                margin: EdgeInsets.only(right: 20, bottom: 15),
                color: Colors.blueAccent,
                textColor: Colors.white,
              )
            ],
          )
          
        ],
      ),
    );
  }

  Widget _imageUser() {
    return Container(
        width: 60,
        // margin: EdgeInsets.only(top: 25, bottom: 15),
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipOval(
            child: driverTripRequest != null 
            ? driverTripRequest!.driver!.image != null 
              ? FadeInImage.assetNetwork(
                placeholder: 'assets/img/user_image.png', 
                image: driverTripRequest!.driver!.image!,
                fit: BoxFit.cover,
                fadeInDuration: Duration(seconds: 1),
              )
              : Image.asset(
                'assets/img/user_image.png',
              )
            : Container(),
          ),
        ),
      );
  }
}