import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/actions/common_buttons/outlined_button.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/utils.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/camera/bloc/camera_state.dart';
import 'package:bite/ui/scene/camera/bloc/camera_cubit.dart';
import 'package:go_router/go_router.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraState();
}

class _CameraState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => CameraCubit(),
        child: BlocListener<CameraCubit, CameraState>(
          listener: (context, state) {
            if (state is CameraError) {
              // Error state dialog
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
          child: BlocBuilder<CameraCubit, CameraState>(
            builder: (context, state) {
              final cubit = context.read<CameraCubit>();

              if (state is CameraLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              if (state is CameraSuccess) {
                return SafeArea(
                  child: Scaffold(
                    body: Stack(
                      children: <Widget>[
                        CameraPreview(cubit.cameraController),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: FloatingActionButton(
                              onPressed: () {
                                cubit.takePicture();
                              },
                              backgroundColor: Colors.white,
                              foregroundColor: BiteColors.primaryColor,
                              child: const Icon(Icons.camera),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is CameraImagePreview) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      spacing: 16,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                         BiteTitleH1Text(text: context.l10n?.previewLabel ?? ''),
                        Image.file(state.image),

                        BiteOutlinedButton(
                          onPressed: () {
                            cubit.takeImage();
                          },
                          width: double.maxFinite,
                          text: context.l10n?.takeAnotherPhoto ?? '',
                          leftTextPadding: 10,
                          rightTextPadding: 10,
                          topTextPadding: 10,
                          bottomTextPadding: 10,
                          borderRadius: 16,
                          textOverflow: TextOverflow.ellipsis,
                        ),

                        // Report button
                        BiteFilledButton(
                          onPressed: () {
                            context.pop(cubit.selectedImage);
                          },
                          width: double.maxFinite,
                          text:  context.l10n?.continueWithReport ?? '',
                          prefixIconColor: BiteColors.black,
                          prefixIconName: 'icon_report',
                          leftPadding: 10,
                          rightPadding: 10,
                          topPadding: 10,
                          bottomPadding: 10,
                          borderRadius: 16,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
