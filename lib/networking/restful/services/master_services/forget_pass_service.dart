import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> forgetPassService({

    required String mail ,
 
    
  }) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.forgetPassword}' ;
  final httpService = HttpServices();

  http.Response? response;
  await httpService.post (
   url:  endpoint,
       body: {
        "email": "$mail",
 
      }).then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
