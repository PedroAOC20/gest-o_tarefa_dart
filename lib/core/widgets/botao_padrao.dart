import 'package:flutter/material.dart';

class BotaoPadrao extends StatelessWidget {
  final String texto;
  final VoidCallback onPressed;
  final IconData? icone;
  final Color? corDeFundo;

  const BotaoPadrao({
    Key? key,
    required this.texto,
    required this.onPressed,
    this.icone,
    this.corDeFundo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            corDeFundo ?? Theme.of(context).primaryColor ?? Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icone != null) ...[
            Icon(icone, color: Colors.white),
            const SizedBox(width: 10),
          ],
          Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
