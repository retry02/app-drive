import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/src/domain/models/ClientRequestResponse.dart';
import 'package:indriver_clone_flutter/src/domain/utils/Resource.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/DriverHistoryTripItem.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripState.dart';

class DriverHistoryTripPage extends StatefulWidget {
  const DriverHistoryTripPage({super.key});

  @override
  State<DriverHistoryTripPage> createState() => _DriverHistoryTripPageState();
}

class _DriverHistoryTripPageState extends State<DriverHistoryTripPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DriverHistoryTripBloc>().add(GetHistoryTrip());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverHistoryTripBloc, DriverHistoryTripState>(
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
                return DriverHistoryTripItem(data[index]);
              }
          );
        }
        return Container();
      },
    );
  }
}
