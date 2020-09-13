class ApiConfiguration {
  String baseUrl;
  String secureBaseUrl;
  String apiKey;

  ApiConfiguration(dynamic json) {
    this.apiKey = 'a1ee451bc60cbe60eccd78855de189ec';
    var images = json['images'];
    this.baseUrl = images['base_url'] as String;
    this.secureBaseUrl = images['secure_base_url'] as String;
  }

  String mountImageUrl({String imgPath, String size = 'w500'}) {
    return secureBaseUrl + size + imgPath;
  }
}
