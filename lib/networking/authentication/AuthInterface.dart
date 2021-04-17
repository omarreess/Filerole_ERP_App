

import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
abstract class AuthInterface
{

  String  generateHeader (String token) ;

  String endpointLink ;
  String loginQuery;
  String logoutQuery;
  String getProfileQuery;
  String forgetPasswordQuery;

  GraphQLClient graphQLClient({String endpoint , String token}) ;
  Future<QueryResult> graphQLClientRequest({String queryDoc , Map<String , dynamic> args, String token}) ;



}