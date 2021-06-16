bool checkNetworkResponseStatusCode (Map<String, dynamic>? response) {
  if (response?['status'] == 200) {
    return true;
  } else {
    return false;
  }
}
