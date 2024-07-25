import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/historyTrip/ClientHistoryTripItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/historyTrip/bloc/ClientHistoryTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/historyTrip/bloc/ClientHistoryTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/historyTrip/bloc/ClientHistoryTripState.dart';

class ClientHistoryTripPage extends StatefulWidget {
  const ClientHistoryTripPage({super.key});

  @override
  State<ClientHistoryTripPage> createState() => _ClientHistoryTripPageState();
}

class _ClientHistoryTripPageState extends State<ClientHistoryTripPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ClientHistoryTripBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientHistoryTripBloc, ClientHistoryTripState>(
      builder: (context, state) {
        final response = state.response;
        if (response is Loading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (response is Success) {
          List<ClientRequestResponse> data = response.data as List<ClientRequestResponse>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ClientHistoryTripItem(data[index]);
              }
          );
        }
        return Container();
      },
    );
  }
}
