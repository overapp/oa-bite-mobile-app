import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/scene/splash/bloc/splash_cubit.dart';
import 'package:bite/ui/scene/splash/bloc/splash_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (createContext) => SplashCubit(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            final cubit = context.read<SplashCubit>();

            if (state is SplashLoaded) {
              cubit.checkBluetoothPermission();
            }

            if (state is SplashPermissionChechLoaded) {
              bool shouldAskBluetoothPermission =
                  state.shouldAskBluetoothPermission!;
              if (shouldAskBluetoothPermission) {
                context.go(Routes.bluetoothPermission);
              } else {
                context.go(Routes.home);
              }
            }

            if (state is SplashError) {
              showBiteDialog(
                context,
                'icon_close',
                context.l10n!.errorTitle,
                context.l10n!.genericError,
                action2Message: context.l10n!.okLabel,
                onAction2Tap: () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: BlocBuilder<SplashCubit, SplashState>(
            builder: (context, state) {
              return Container(
                color: BiteColors.bgColor,
                child: const Center(
                  child: BiteIcon(iconName: 'icon_logo'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
