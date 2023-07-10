// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tktinder/models/user_match_model.dart';

import '../../widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';
  final UserMatch userMatch;
  const ChatScreen({super.key, required this.userMatch});

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(userMatch: userMatch),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                userMatch.matchedUser.imageUrls[0],
              ),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headlineMedium,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _messageList()),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Type here...",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      contentPadding: EdgeInsets.only(
                        left: 20,
                        bottom: 5,
                        top: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _messageList() {
    return SingleChildScrollView(
      child: userMatch.chat != null
          ? SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: userMatch.chat![0].messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: userMatch.chat![0].messages[index].senderId == 1
                        ? MessageTile(
                            userMatch: userMatch,
                            index: index,
                            alignment: Alignment.topRight)
                        : Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                  userMatch.matchedUser.imageUrls[0],
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              MessageTile(
                                userMatch: userMatch,
                                index: index,
                                alignment: Alignment.topLeft,
                                host: true,
                              ),
                            ],
                          ),
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }
}

class MessageTile extends StatelessWidget {
  final UserMatch userMatch;
  final int index;
  final AlignmentGeometry alignment;
  final bool host;
  const MessageTile({
    Key? key,
    required this.userMatch,
    required this.index,
    required this.alignment,
    this.host = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: host ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: host
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.background),
        child: Text(
          userMatch.chat![0].messages[index].message,
          style: host
              ? Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Colors.white)
              : Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
