// import 'package:data_connection_checker/data_connection_checker.dart';
//
// bool _netState = true;
// bool get netState => _netState;
// set netState(bool netState) { if(_netState != netState)  _netState = netState; }
//
// Stream <DataConnectionStatus> networkStatusStream ()
//   {
//
//   return DataConnectionChecker().onStatusChange;
// }
//
// void checkNetworkStatus (DataConnectionStatus status)
//  {
//   switch (status) {
//     case DataConnectionStatus.connected:
//       netState=true;
//
//       break;
//
//     case DataConnectionStatus.disconnected:
//       netState=false;
//
//       break;
//   }
//
//  }