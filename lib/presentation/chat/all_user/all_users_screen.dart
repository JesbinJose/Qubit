import 'package:flutter/material.dart';
import 'package:qubit/cache.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  Widget build(BuildContext context) {
    print(JwtDecoder.decode(apiKey)['user_id']);
    return Scaffold(
      body: Row(
        children: [
          // Column(
          //   children: [
          //     Container(
          //       child: Row(
          //         children: [Text('')],
          //       ),
          //     ),
          //     ListView.separated(
          //       itemBuilder: (context, index) => ListTile(),
          //       separatorBuilder: (context, index) => const Divider(),
          //       itemCount: 0,
          //     ),
          //   ],
          // ),
          Container(),
        ],
      ),
    );
  }
}
