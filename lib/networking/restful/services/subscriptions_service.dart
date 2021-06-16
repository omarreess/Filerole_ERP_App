import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> subscriptionsService({

     
     required String token 
    
  }) async {
    
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.subscriptions}' ;
  final httpService = HttpServices(token:token );

  http.Response? response;
  await httpService.get (
   url:  endpoint,
       parameters: {
        

      })
      .then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
