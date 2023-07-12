import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tktinder/cubits/signup/signup_cubit.dart';
import 'package:tktinder/repositories/auth/auth_repository.dart';
import 'package:tktinder/widgets/widgets.dart';

import 'onboarding_screens/screens.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => SignupCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const OnboardingScreen(),
      ),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    Tab(text: 'Location')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });
        return Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(56.0),
            child: CustomAppBar(
              title: 'ARROW',
              hasActions: false,
            ),
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              Email(tabController: tabController),
              EmailVerification(tabController: tabController),
              Pictures(tabController: tabController),
              Demo(tabController: tabController),
              Bio(tabController: tabController),
              Location(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
