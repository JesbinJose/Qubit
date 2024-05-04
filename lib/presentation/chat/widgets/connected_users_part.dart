import 'package:flutter/material.dart';
import 'package:qubit/presentation/chat/widgets/all_connections_list.dart';
import 'package:qubit/presentation/chat/widgets/custom_app_bar.dart';
import 'package:qubit/presentation/chat/widgets/custom_search_bar.dart';

class ConnectedUsersPart extends StatelessWidget {
  const ConnectedUsersPart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(),
              SizedBox(height: 20),
              CustomSearchBar(),
              SizedBox(height: 20),
              AllConnectionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
