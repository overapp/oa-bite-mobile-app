import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/ui/components/app_bar/app_bar.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/components/text/text_title_h2.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/tabs/credits/bloc/credits_state.dart';
import 'package:bite/ui/scene/tabs/credits/bloc/credits_cubit.dart';
import 'package:go_router/go_router.dart';

class CreditsScreen extends StatefulWidget {
  const CreditsScreen({super.key});

  @override
  State<CreditsScreen> createState() => _CreditsState();
}

class _CreditsState extends State<CreditsScreen> {
  String? calledFrom;
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extraParams =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraParams != null) {
      calledFrom = extraParams['calledFrom'] as String?;
    }
    return Scaffold(
      body: BlocProvider(
        create: (context) => CreditsCubit(),
        child: BlocListener<CreditsCubit, CreditState>(
          listener: (context, state) {},
          child: BlocBuilder<CreditsCubit, CreditState>(
            builder: (context, state) {
              if (state is CreditLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              return Scaffold(
                appBar: BiteAppBar(
                  title: context.l10n!.creditsScreenTitle,
                  backgroundColor: BiteColors.bgColor,
                  onIconTap: () {
                    if (calledFrom == null) {
                      context.pop();
                      return;
                    }
                    context.pushReplacement(calledFrom!);
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    spacing: 24,
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: BiteIcon(
                          iconName: 'icon_logo_green',
                          height: 148,
                          width: 148,
                        ),
                      ),
                      BiteTitleH2Text(
                        text: context.l10n!.madeWithLove,
                      ),
                      BiteTitleH1Text(
                        text: context.l10n!.creditsCompanyLabel,
                      ),
                      BiteBodyB1Text(
                        text: context.l10n!.creditsTextLabel,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
