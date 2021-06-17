import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> updateFcmTokenService({

   
     required String token ,
     required String tokenFcm,
    
  }) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.fcmTokenUpdate}' ;
  final httpService = HttpServices(token:token );

  http.Response? response;
  await httpService.post (
     body: {
        "device_token": "$tokenFcm",
      },
   url:  endpoint,
      )
      .then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
