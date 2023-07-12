import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tktinder/cubits/signup/signup_cubit.dart';
import 'package:tktinder/screens/onboarding/widgets/widgets.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  const CustomTextHeader(text: 'What\'s Your Email Address?'),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (val) {
                      context.read<SignupCubit>().emailChanged(value: val);
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  const CustomTextHeader(text: 'Choose a Password'),
                  CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (val) {
                      context.read<SignupCubit>().passwordChanged(value: val);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).colorScheme.background,
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    tabController: tabController,
                    text: 'NEXT STEP',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
