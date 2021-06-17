import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> profileUpdatePassService({

    required String currentPass ,
    required String newPass ,
    required String newPassRe,
    required String token ,
    
  }) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.profilePasswordUpdate}' ;
  final httpService = HttpServices(token:token );

  http.Response? response;
  await httpService.post (
   url:  endpoint,
       body: {
        'current_password' : '$currentPass',
        'password' : '$newPass',
        'password_confirmation': '$newPassRe'
      })
      .then((requestResponse) {
    response = requestResponse;
  });
  return response;
}
