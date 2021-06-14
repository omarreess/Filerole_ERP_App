import 'package:http/http.dart' as http;
import 'package:Filerole/networking/restful/endpoints/master_endpoints.dart';
import 'package:Filerole/networking/restful/services/shared/http_services.dart';

Future<http.Response?> profileUpdateService(
    {String? mail,
    String? firstName,
    String? lastName,
    String? phoneNo,
    required String token}) async {
  final masterEndpoints = MasterEndpoints();
  final endpoint = '${masterEndpoints.baseUrl}${masterEndpoints.profileUpdate}';
  final httpService = HttpServices(token: token);

  http.Response? response;
  await httpService.post(url: endpoint, body: {
    'email': '$mail',
    'first_name': '$firstName',
    'last_name': '$lastName',
    'phone_number': '$phoneNo'
  }).then((requestResponse) {
    response = requestResponse;
  });
 
   return response;
}
