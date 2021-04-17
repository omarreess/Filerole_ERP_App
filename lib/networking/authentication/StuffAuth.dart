



import 'package:graphql_flutter/graphql_flutter.dart';

import 'AuthInterface.dart';

class StuffAuth implements AuthInterface {

  @override
  String endpointLink;

  @override
  GraphQLClient graphQLClient(  {String endpoint ,String token}) {
    return GraphQLClient(

        cache: GraphQLCache(store: HiveStore()),
        link:  (token==null)
            ? HttpLink( endpointLink    )
            : AuthLink(
          getToken: ()  => generateHeader(token),
        ) . concat(HttpLink( endpointLink   ))

    );
  }

  @override
  String forgetPasswordQuery;

  @override
  String loginQuery;

  @override
  String logoutQuery;


  @override
  String  generateHeader(String token) {
    return
      "Bearer $token"
    ;
  }
  @override
  Future<QueryResult> graphQLClientRequest({ String queryDoc, Map<String, dynamic> args , String token }) {

    return graphQLClient(endpoint :endpointLink, token: token ).query(
      QueryOptions(
        document:gql(queryDoc) ,
        variables:args,


      ),
    );

  }

  @override
  String getProfileQuery = """
  {
  profile  {
      id 
      email
      phone_number
      address 
      
    }
}
  
  """ ;








}