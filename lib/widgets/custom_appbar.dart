import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tktinder/screens/profile/profile_screen.dart';
import 'package:tktinder/screens/screens.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool hasActions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.hasActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              child: SvgPicture.asset(
                'lib/assets/logo.svg',
                height: 50,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                  icon: Icon(Icons.message,
                      color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, MatchesScreen.routeName);
                  }),
              IconButton(
                  icon:
                      Icon(Icons.person, color: Theme.of(context).primaryColor),
                  onPressed: () {
                    Navigator.pushNamed(context, ProfileScreen.routeName);
                  })
            ]
          : null,
    );
  }
}
