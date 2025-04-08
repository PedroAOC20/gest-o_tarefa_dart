import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CampoTexto extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? mascara;
  final Future<void> Function()? onTap;
  final int maxLines;

  const CampoTexto({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.isPassword = false,
    this.mascara,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // Define uma altura fixa para o campo, para centralização
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon:
              prefixIcon != null
                  ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Icon(prefixIcon, size: 24, color: Colors.black54),
                  )
                  : null,
          floatingLabelBehavior: FloatingLabelBehavior.never, // Label fixo
          alignLabelWithHint: true, // Alinha o label com o hint
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0, // Ajusta o padding vertical para centralizar o texto
            horizontal: 12,
          ),
          border: Theme.of(context).inputDecorationTheme.border,
          enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
          focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
          errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
          filled: true,
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        ),
        style: const TextStyle(color: Colors.black, height: 1.0),
        textAlignVertical:
            TextAlignVertical.center, // Centraliza o texto digitado
        obscureText: isPassword,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validator,
        onTap: onTap,
        maxLines: maxLines,
        inputFormatters:
            mascara != null
                ? [
                  MaskTextInputFormatter(
                    mask: mascara,
                    filter: {"#": RegExp(r'[0-9]')},
                  ),
                ]
                : null,
      ),
    );
  }
}
