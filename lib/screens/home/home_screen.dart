import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktinder/blocs/blocs.dart';
import 'package:tktinder/models/models.dart';

import 'package:tktinder/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/homescreen';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: CustomAppBar(title: 'DISCOVER')),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            return Column(
              children: [
                InkWell(
                  onDoubleTap: () {
                    Navigator.pushNamed(context, '/users',
                        arguments: state.users[0]);
                  },
                  child: Draggable<User>(
                    data: state.users[0],
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: UserCard(user: state.users[1]),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeLeftEvent(user: state.users[0]));
                        log('Swiped Left');
                      } else {
                        context
                            .read<SwipeBloc>()
                            .add(SwipeRightEvent(user: state.users[0]));
                        log('Swiped Right');
                      }
                    },
                    child: UserCard(user: state.users[0]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 60,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRightEvent(user: state.users[0]));
                          log('Swiped Right');
                        },
                        child: ChoiceButton(
                          color: Theme.of(context).colorScheme.secondary,
                          icon: Icons.clear_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<SwipeBloc>()
                              .add(SwipeRightEvent(user: state.users[0]));
                          log('Swiped Left');
                        },
                        child: const ChoiceButton(
                          width: 80,
                          height: 80,
                          size: 30,
                          color: Colors.white,
                          hasGradient: true,
                          icon: Icons.favorite,
                        ),
                      ),
                      ChoiceButton(
                        color: Theme.of(context).primaryColor,
                        icon: Icons.watch_later,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Text('Something went wrong.');
          }
        },
      ),
    );
  }
}
