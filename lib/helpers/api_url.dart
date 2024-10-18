class ApiUrl {
  static const String baseUrl =
      'http://responsi.webwizards.my.id'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String baseUrlPariwisata = baseUrl + '/api/pariwisata';
  static const String registrasi = baseUrl + '/api/registrasi';
  static const String login = baseUrl + '/api/login';
  static const String listProduk = baseUrlPariwisata + '/durasi_tur';
  static const String createProduk = baseUrlPariwisata + '/durasi_tur';

  static String updatePariwisata(int id) {
    return baseUrlPariwisata +
        '/durasi_tur/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String showPariwisata(int id) {
    return baseUrlPariwisata +
        '/durasi_tur/' +
        id.toString(); //sesuaikan dengan url API yang sudah dibuat
  }

  static String deletePariwisata(int id) {
    return baseUrlPariwisata +
        '/durasi_tur/' +
        id.toString() +
        '/delete'; //sesuaikan dengan url API yang sudah dibuat
  }
}
