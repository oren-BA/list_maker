import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:list_maker/config.dart';

Future<http.Response> getUserLists(String token) {
  return http.post(
    Uri.http('10.0.2.2:5000', '/get_lists'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      CONFIG.token: token,
    }),
  );
}


Future<http.Response> listAction(String token, String action, String listName) {
  action = '/' + action;
  return http.post(
    Uri.http('10.0.2.2:5000', action),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      CONFIG.token: token,
      CONFIG.list_name: listName,
    }),
  );
}



Future<http.Response> itemActionAPI(String token, String action, String listName,
    String itemName, String companyName) {
  action = '/' + action;
  return http.post(
    Uri.http('10.0.2.2:5000', action),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      CONFIG.token: token,
      CONFIG.list_name: listName,
      CONFIG.item_name: itemName,
      CONFIG.company_name: companyName,
    }),
  );
}
