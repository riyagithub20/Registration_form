import 'package:flutter/material.dart';

class SnackBarCustom extends StatelessWidget {
  const SnackBarCustom({super.key});

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This is a snack bar'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snack Bar Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSnackBar(context),
          child: Text('Show Snack Bar'),
        ),
      ),
    );
  }
}
