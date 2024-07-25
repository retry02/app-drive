import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/presentation/widgets/DefaultImageUrl.dart';

class DriverHistoryTripItem extends StatelessWidget {

  ClientRequestResponse clientRequest;

  DriverHistoryTripItem(this.clientRequest);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        child: Column(
          children: [
            _listTileClient(),
            _listTilePickup(),
            _listTileDestination(),
            _listTileFarePaid(),
            _listTileTime()
          ],
        ),
      ),
    );
  }

  Widget _listTilePickup() {
    return ListTile(
      title: Text('Desde'),
      subtitle: Text(clientRequest.pickupDescription),
      trailing: Icon(Icons.location_on),
    );
  }

  Widget _listTileDestination() {
    return ListTile(
      title: Text('Hasta'),
      subtitle: Text(clientRequest.destinationDescription),
      trailing: Icon(Icons.flag),
    );
  }

  Widget _listTileFarePaid() {
    return ListTile(
      title: Text('Tarifa del viaje'),
      subtitle: Text('\$${clientRequest.fareAssigned}'),
      trailing: Icon(Icons.attach_money_outlined),
    );
  }

  Widget _listTileClient() {
    return ListTile(
      title: Text('Cliente'),
      subtitle: Text('${clientRequest.client.name} ${clientRequest.client.lastname}'),
      trailing: DefaultImageUrl(
        url: clientRequest.client.image,
        width: 50,
      ),
    );
  }

  Widget _listTileTime() {
    return ListTile(
      title: Text('Fecha del viaje'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inicio: ${clientRequest.createdAt}'),
          Text('Fin: ${clientRequest.updatedAt}'),
        ],
      ),
      trailing: Icon(
        Icons.watch_later
      )
    );
  }

  
}