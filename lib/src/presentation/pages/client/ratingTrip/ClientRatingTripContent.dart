import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripState.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultButton.dart';

class ClientRatingTripContent extends StatelessWidget {
  
  ClientRatingTripState state;
  ClientRequestResponse? clientRequestResponse;

  ClientRatingTripContent(this.state, this.clientRequestResponse);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        _iconCheck(),
        SizedBox(height: 15),
        _textFinished(),
        SizedBox(height: 30),
        _listTilePickup(),
        _listTileDestination(),
        SizedBox(height: 70),
        _textFare(),
        _textFareValue(),
        SizedBox(height: 20),
        _textRateYourClient(),
        _ratingBar(context),
        Spacer(),
        DefaultButton(
          text: 'CALIFICAR CONDUCTOR', 
          onPressed: () {
            context.read<ClientRatingTripBloc>().add(UpdateRating(idClientRequest: clientRequestResponse!.id));
          }
        )
      ],
    );
  } 

  Widget _textFareValue() {
    return Text(
      '\$${clientRequestResponse?.fareAssigned}',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
        color: Colors.yellow
      ),
    );
  }

  Widget _textFare() {
    return Text(
      'VALOR DEL VIAJE',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white
      ),
    );
  }

  Widget _textRateYourClient() {
    return Text(
      'CALIFICA A TU CONDUCTOR',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white
      ),
    );
  }

  Widget _ratingBar(BuildContext context) {
    return RatingBar.builder(
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ), 
      initialRating: 0,
      itemCount: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.grey[300],
      onRatingUpdate: (rating) {
        context.read<ClientRatingTripBloc>().add(RatingChanged(rating: rating));
      }
    );
  }

  Widget _listTileDestination() {
    return ListTile(
      leading: Icon(Icons.flag, color: Colors.white,),
      title: Text(
        'HASTA',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        clientRequestResponse?.destinationDescription ?? '',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

  Widget _listTilePickup() {
    return ListTile(
      leading: Icon(Icons.location_on, color: Colors.white,),
      title: Text(
        'DESDE',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      subtitle: Text(
        clientRequestResponse?.pickupDescription ?? '',
        style: TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

  Widget _textFinished() {
    return Text(
      'TU VIAJE HA FINALIZADO',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    );
  }

  Widget _iconCheck() {
    return Icon(
      Icons.check_circle,
      color: Colors.white,
      size: 100,
    );
  }
}