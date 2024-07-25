import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:indriver_clone_flutter/blocSocketIO/BlocSocketIO.dart';
import 'package:indriver_clone_flutter/injection.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/auth/AuthUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/client-requests/ClientRequestsUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-car-info/DriverCarInfoUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/driver-trip-request/DriverTripRequestUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/drivers-position/DriversPositionUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/geolocator/GeolocatorUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/socket/SocketUseCases.dart';
import 'package:indriver_clone_flutter/src/domain/useCases/users/UsersUseCases.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/login/bloc/LoginEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/auth/register/bloc/RegisterEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/driverOffers/bloc/ClientDriverOffersBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/historyTrip/bloc/ClientHistoryTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/home/bloc/ClientHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapBookingInfo/bloc/ClientMapBookingInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapSeeker/bloc/ClientMapSeekerBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/mapTrip/bloc/ClientMapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/client/ratingTrip/bloc/ClientRatingTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/carInfo/bloc/DriverCarInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/clientRequests/bloc/DriverClientRequestsBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/historyTrip/bloc/DriverHistoryTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/home/bloc/DriverHomeBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapLocation/bloc/DriverMapLocationBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/mapTrip/bloc/DriverMapTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/driver/ratingTrip/bloc/DriverRatingTripBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/info/bloc/ProfileInfoEvent.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/profile/update/bloc/ProfileUpdateBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/roles/bloc/RolesBloc.dart';
import 'package:indriver_clone_flutter/src/presentation/pages/roles/bloc/RolesEvent.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<AuthUseCases>(), locator<UsersUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<BlocSocketIO>(create: (context) => BlocSocketIO(locator<SocketUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientHomeBloc>(create: (context) => ClientHomeBloc(locator<AuthUseCases>())),
  BlocProvider<DriverHomeBloc>(create: (context) => DriverHomeBloc(locator<AuthUseCases>())),
  BlocProvider<RolesBloc>(create: (context) => RolesBloc(locator<AuthUseCases>())..add(GetRolesList())),
  BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<UsersUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientMapSeekerBloc>(create: (context) => ClientMapSeekerBloc(context.read<BlocSocketIO>(), locator<GeolocatorUseCases>(), locator<SocketUseCases>())),
  BlocProvider<ClientMapBookingInfoBloc>(create: (context) => ClientMapBookingInfoBloc(context.read<BlocSocketIO>(), locator<GeolocatorUseCases>(), locator<ClientRequestsUseCases>(), locator<AuthUseCases>())),
  BlocProvider<DriverClientRequestsBloc>(create: (context) => DriverClientRequestsBloc(context.read<BlocSocketIO>(), locator<ClientRequestsUseCases>(), locator<DriversPositionUseCases>(), locator<AuthUseCases>(), locator<DriverTripRequestUseCases>())),
  BlocProvider<ClientDriverOffersBloc>(create: (context) => ClientDriverOffersBloc(context.read<BlocSocketIO>(), locator<DriverTripRequestUseCases>(), locator<ClientRequestsUseCases>())),
  BlocProvider<DriverMapLocationBloc>(create: (context) => DriverMapLocationBloc(context.read<BlocSocketIO>(), locator<GeolocatorUseCases>(),locator<SocketUseCases>(), locator<AuthUseCases>(), locator<DriversPositionUseCases>())),
  BlocProvider<DriverCarInfoBloc>(create: (context) => DriverCarInfoBloc(locator<AuthUseCases>(), locator<DriverCarInfoUseCases>())),
  BlocProvider<ClientMapTripBloc>(create: (context) => ClientMapTripBloc(context.read<BlocSocketIO>(), locator<ClientRequestsUseCases>(), locator<GeolocatorUseCases>(), locator<AuthUseCases>())),
  BlocProvider<DriverMapTripBloc>(create: (context) => DriverMapTripBloc(context.read<BlocSocketIO>(), locator<ClientRequestsUseCases>(), locator<GeolocatorUseCases>())),
  BlocProvider<DriverRatingTripBloc>(create: (context) => DriverRatingTripBloc(locator<ClientRequestsUseCases>())),
  BlocProvider<ClientRatingTripBloc>(create: (context) => ClientRatingTripBloc(locator<ClientRequestsUseCases>())),
  BlocProvider<DriverHistoryTripBloc>(create: (context) => DriverHistoryTripBloc(locator<ClientRequestsUseCases>(), locator<AuthUseCases>())),
  BlocProvider<ClientHistoryTripBloc>(create: (context) => ClientHistoryTripBloc(locator<ClientRequestsUseCases>(), locator<AuthUseCases>())),
];