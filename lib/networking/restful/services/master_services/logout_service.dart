import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> logoutService({

     
    required String token 
    
  }) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.logout}' ;
  final httpService = HttpServices(token:token );

  http.Response? response;
  await httpService.post (
   url:  endpoint,
       body: {
        
      })
      .then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
