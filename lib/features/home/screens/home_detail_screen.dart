import 'package:flutter/material.dart';

import 'package:erb_flutter_boilerplate/routes/routes.dart';

@RoutePage()
class HomeDetailScreen extends StatelessWidget {
  const HomeDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('home detail'),
      ),
    );
  }
}
