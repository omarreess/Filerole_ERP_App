



 import 'package:graphql/src/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'AuthInterface.dart';

class MasterAuth implements AuthInterface {
  //header
  /*
  {
   "Authorization": "Bearer hwjeYzhbkXWD4A6k9yYC77DJJzCrPu43kcbjrWnjVAQQpavKKR"
  }
   */
  @override
 String  generateHeader(String token) {
   return   
      "Authorization: Bearer $token"
     ;
   }


  @override
  String endpointLink = "https://filerolesys.com/public/graphql";

  @override
  String forgetPasswordQuery  ;

  @override
  String loginQuery = '''
  mutation MasterLogin (\$email: String! , \$pass: String! , \$url: String! , \$userType: String!  )
{
  login(
    input: { email: \$email, password: \$pass , url: \$url ,  userType: \$userType }) 
  {
    status
    message
    endPoint
    userType
    token
    
    user{
      id 
      name
      email
      phone_number
      address 
    }
    
  }
}
  ''';
  //mock login data
  // "email"  : "hello@fr3on.info" ,
  //   "pass" : "123456" ,
  //   "url": "http://test.filerolesys.com/" ,
  //    "userType": "owner",


  @override
  String logoutQuery = '''
  mutation {
 logout{
  email
}
}
  ''';
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
  
  """;






}