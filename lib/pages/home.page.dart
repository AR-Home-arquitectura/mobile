import 'package:arhome/providers/user.provider.dart';
import 'package:arhome/widgets/products-table.widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      body: userProvider.signIn == false
          ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
          : const ProductsTable(),
    );
  }
}