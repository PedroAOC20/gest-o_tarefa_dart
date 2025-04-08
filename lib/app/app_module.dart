import 'package:flutter/material.dart';
import '../infraestrutura/gerenciamento_estado/providers.dart';

class AppModule extends StatelessWidget {
  final Widget child;

  const AppModule({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Providers.configurarProviders(child: child);
  }
}
