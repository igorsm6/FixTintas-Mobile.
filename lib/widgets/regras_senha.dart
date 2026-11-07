import 'package:flutter/material.dart';

/// Regras da senha — as mesmas que a API confere (FixTintas.Modelos/RegrasDaSenha.cs):
/// no mínimo 8 caracteres, com pelo menos uma letra e pelo menos um número.
/// Mudou a regra na API? Mude aqui também.
class RegrasSenha {
  static const int tamanhoMinimo = 8;

  /// Letras de A a Z, com ou sem acento (as mesmas da API).
  static final RegExp _letra = RegExp(r'[A-Za-zÀ-ÖØ-öø-ÿ]');
  static final RegExp _numero = RegExp(r'[0-9]');

  static bool temTamanho(String s) => s.length >= tamanhoMinimo;
  static bool temLetra(String s) => _letra.hasMatch(s);
  static bool temNumero(String s) => _numero.hasMatch(s);

  /// Para usar no `validator` de um TextFormField.
  static String? validar(String? senha) {
    final s = senha ?? '';
    if (!temTamanho(s) || !temLetra(s) || !temNumero(s)) {
      return 'A senha deve ter no mínimo 8 caracteres, com letras e números.';
    }
    return null;
  }
}

/// Caixa "A senha precisa ter:" que fica embaixo do campo de senha.
/// Cada regra fica verde, com ✓, assim que a pessoa a cumpre.
class CaixaRegrasSenha extends StatelessWidget {
  const CaixaRegrasSenha({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, valor, _) {
        final s = valor.text;
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF4FB),
            border: Border.all(color: const Color(0xFFC9DAF0)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('A senha precisa ter:',
                  style: tema.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: tema.colorScheme.primary)),
              const SizedBox(height: 4),
              _Regra(texto: 'No mínimo 8 caracteres', cumprida: RegrasSenha.temTamanho(s)),
              _Regra(texto: 'Pelo menos uma letra', cumprida: RegrasSenha.temLetra(s)),
              _Regra(texto: 'Pelo menos um número', cumprida: RegrasSenha.temNumero(s)),
            ],
          ),
        );
      },
    );
  }
}

class _Regra extends StatelessWidget {
  const _Regra({required this.texto, required this.cumprida});

  final String texto;
  final bool cumprida;

  @override
  Widget build(BuildContext context) {
    final cor = cumprida ? const Color(0xFF1E7E34) : Colors.black54;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        children: [
          Icon(cumprida ? Icons.check_circle : Icons.radio_button_unchecked, size: 16, color: cor),
          const SizedBox(width: 6),
          Flexible(child: Text(texto, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cor))),
        ],
      ),
    );
  }
}
