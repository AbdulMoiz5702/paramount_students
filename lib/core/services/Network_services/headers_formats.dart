



class HeadersFormats {


  static Map<String, String> defaultHeaders() {
    return {
      'Accept':'application/json',
      'Content-Type':'application/json',
    };
  }

  static Map<String, String> bearerTokenHeaders({required String token}) {
    return {
      'Accept':'application/json',
      'Content-Type':'application/json',
      'Authorization':'Bearer $token'
    };
  }


}