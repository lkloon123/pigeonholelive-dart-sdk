class Config {
  String baseUrl;
  int? perPage;

  Config({
    this.baseUrl = 'https://api.pigeonholelive.com/v2',
    this.perPage,
  });
}
