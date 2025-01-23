import 'package:bite/managers/bluetooth/bluetooth_manager.dart';
import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/bluetooth_permission/bloc/bluetooth_permission_state.dart';
import 'package:bite/ui/scene/bluetooth_permission/bloc/bluetooth_permission_cubit.dart';
import 'package:go_router/go_router.dart';

// This screen prompts the user to grant Bluetooth permissions, typically displayed during the app's initial launch.
class BluetoothPermissionScreen extends StatefulWidget {
  const BluetoothPermissionScreen({super.key});

  @override
  State<BluetoothPermissionScreen> createState() => _BluetoothPermissionState();
}

class _BluetoothPermissionState extends State<BluetoothPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => BluetoothPermissionCubit(),
        child: BlocListener<BluetoothPermissionCubit, BluetoothPermissionState>(
          listener: (context, state) {
            if (state is BluetoothPermissionSuccess) {
              // Initialize Bluetooth Manager for start scan
              BluetoothManager().init();
              context.go(Routes.home);
            }

            if (state is BluetoothPermissionError) {
              context.go(Routes.home);
            }
          },
          child:
              BlocBuilder<BluetoothPermissionCubit, BluetoothPermissionState>(
            builder: (context, state) {
              final cubit = context.read<BluetoothPermissionCubit>();

              if (state is BluetoothPermissionLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const BiteIcon(
                        iconName: 'icon_bluetooth',
                      ),
                      const SizedBox(height: 16.0),
                      BiteTitleH1Text(
                        text: context.l10n!.bluetoothPermissionInfoLabel,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BiteFilledButton(
                            onPressed: () {
                              cubit.askBluetoothPermission();
                            },
                            width: double.maxFinite,
                            text: context.l10n!.nextLabel,
                            leftPadding: 10,
                            rightPadding: 10,
                            topPadding: 10,
                            bottomPadding: 10,
                            borderRadius: 16,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ],
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
