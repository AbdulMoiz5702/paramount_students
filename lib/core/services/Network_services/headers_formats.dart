



class HeadersFormats {

  static Map<String, String> getDefaultHeaders({required String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Map<String, String> defaultHeaders() {
    return {
      'Accept':'application/json',
      'Content-Type':'application/json',
    };
  }

}