import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Configuração de acesso à API ASP.NET.
///
/// Dá para trocar o endereço sem mexer no código:
///   flutter run --dart-define=API_URL=http://192.168.0.10:5000
class ApiConfig {
  ApiConfig._();

  /// Porta em que a API ASP.NET roda na sua máquina (veja Properties/launchSettings.json).
  static const int portaLocal = 5000;

  static const String _urlDefinida = String.fromEnvironment('API_URL');

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
