/// Configuração de acesso à API ASP.NET no Azure.
class ApiConfig {
  ApiConfig._();

  static String get baseUrl {
    return 'https://fixtintas-api-igor-hmbnhcendze8hpaa.brazilsouth-01.azurewebsites.net/';
  }

  /// Monta a URL de uma imagem salva pela API (caminho relativo ou absoluto).
  static String urlImagem(String caminho) {
    if (caminho.startsWith('http')) return caminho;
    final limpo =
        caminho.replaceAll('\\', '/').replaceFirst(RegExp(r'^/+'), '');
    return '$baseUrl/$limpo';
  }
}
