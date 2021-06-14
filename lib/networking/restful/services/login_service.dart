import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> loginService({

    required String mail ,
    required String pass ,
    required String type , 
    required String serverUrl 
    
  }) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.login}' ;
  final httpService = HttpServices();

  http.Response? response;
  await httpService.post (
   url:  endpoint,
       body: {
        "email": "$mail",
        "password": "$pass",
        "userType": "$type",
        "url": "$serverUrl"
      }).then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
