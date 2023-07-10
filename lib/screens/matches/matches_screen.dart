import 'package:flutter/material.dart';
import 'package:tktinder/models/user_match_model.dart';
import 'package:tktinder/screens/chat/chat_screen.dart';

import '../../widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  const MatchesScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const MatchesScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat!.isNotEmpty)
        .toList();
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: CustomAppBar(title: 'MATCHES')),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Likes",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: inactiveMatches.length,
                    itemBuilder: (context, index) {
                      final access = inactiveMatches[index].matchedUser;
                      return Column(
                        children: [
                          UserImageSmall(
                            height: 70,
                            width: 70,
                            url: access.imageUrls[0],
                          ),
                          Text(
                            access.name,
                            style: Theme.of(context).textTheme.headlineSmall,
                          )
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Chats",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeMatches.length,
                  itemBuilder: (context, index) {
                    final access = activeMatches[index].matchedUser;
                    final message = activeMatches[index].chat!;
                    return InkWell(
                      highlightColor: Colors.red[200],
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          ChatScreen.routeName,
                          arguments: activeMatches[index],
                        );
                      },
                      child: Row(
                        children: [
                          UserImageSmall(
                            url: access.imageUrls[0],
                            height: 70,
                            width: 70,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                access.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                message[0].messages[0].message,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                message[0].messages[0].timeString,
                                style: Theme.of(context).textTheme.titleLarge,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
