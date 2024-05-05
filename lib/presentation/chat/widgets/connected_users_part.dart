import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubit/presentation/chat/widgets/all_connections_list.dart';
import 'package:qubit/presentation/chat/widgets/custom_app_bar.dart';
import 'package:qubit/presentation/chat/widgets/custom_search_bar.dart';
import 'package:qubit/state/chat/chats_bloc.dart';

class ConnectedUsersPart extends StatefulWidget {
  const ConnectedUsersPart({super.key});

  @override
  State<ConnectedUsersPart> createState() => _ConnectedUsersPartState();
}

class _ConnectedUsersPartState extends State<ConnectedUsersPart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _appBarSlideAnimation;
  late Animation<Offset> _searchBarSlideAnimation;
  late Animation<Offset> _connectionsListSlideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _appBarSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
      ),
    );

    _searchBarSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
      ),
    );

    _connectionsListSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -10),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatsBloc>().add(SearchChatEvent(query: ''));
    return Drawer(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SlideTransition(
                position: _appBarSlideAnimation,
                child: const CustomAppBar(),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _searchBarSlideAnimation,
                child: const CustomSearchBar(),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _connectionsListSlideAnimation,
                child: const AllConnectionsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
