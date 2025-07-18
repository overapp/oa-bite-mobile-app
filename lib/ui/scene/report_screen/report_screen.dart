import 'dart:io';

import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/navigation/routes.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/containers/upload_photo_card.dart';
import 'package:bite/ui/components/text/text_body_b2.dart';
import 'package:bite/ui/components/text/text_title_h1.dart';
import 'package:bite/ui/components/text_inputs/text_area.dart';
import 'package:bite/ui/components/text_inputs/text_field.dart';
import 'package:bite/ui/scene/base_page_screen/base_page_screen.dart';
import 'package:bite/ui/components/app_bar/app_bar.dart';
import 'package:bite/ui/scene/report_screen/bloc/report_cubit.dart';
import 'package:bite/ui/scene/report_screen/bloc/report_state.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/utils/email_validator.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ReportScreen extends BasePageScreen {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController textAreaController = TextEditingController();
  String? poiId;

  List<EmailValidatorError> _emailValidator = [];

  void _validateEmail(String email) {
    setState(() {
      _emailValidator = EmailValidator.validateEmail(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extraParams =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraParams != null) {
      poiId = extraParams['poiId'] as String?;
    }

    return Scaffold(
      backgroundColor: BiteColors.bgColor,
      body: BlocProvider(
        create: (context) => ReportCubit(poiId ?? ''),
        child: BlocListener<ReportCubit, ReportState>(
          listener: (context, state) {
            if (state is ReportPermissionNotGranted) {
              showBiteDialog(
                context,
                'icon_close',
                context.l10n!.attentionLabel,
                context.l10n!.missingPhotoLibraryPermission,
                action1Message: context.l10n!.okLabel,
                onAction1Tap: () {
                  Navigator.of(context).pop();
                },
                action2Message: context.l10n!.enableLabel,
                onAction2Tap: () {
                  openAppSettings();
                },
              );
            }

            if (state is ReportUploadComplete) {
              showBiteDialog(
                context,
                'icon_upload',
                context.l10n!.operationCompleted,
                context.l10n!.sendReport,
                iconColor: BiteColors.black,
                action2Message: context.l10n!.closeLabel,
                onAction2Tap: () {
                  Navigator.of(context).pop();
                  context.pop();
                },
              );
            }

            if (state is ReportError) {
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

            if (state is ReportImageError) {
              showBiteDialog(
                context,
                'icon_close',
                context.l10n!.errorTitle,
                context.l10n!.imageFormatError,
                action2Message: context.l10n!.okLabel,
                onAction2Tap: () {
                  Navigator.of(context).pop();
                },
              );
            }
          },
          child: BlocBuilder<ReportCubit, ReportState>(
            builder: (context, state) {
              final cubit = context.read<ReportCubit>();

              if (state is ReportLoading || state is ReportUploadLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              if (state is ReportSuccess) {}

              return Scaffold(
                appBar: BiteAppBar(
                  backgroundColor: BiteColors.bgColor,
                  title: context.l10n!.reports,
                  onIconTap: () {
                    context.pop();
                  },
                ),
                body: Padding(
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BiteTitleH1Text(text: context.l10n!.reportAProblem),
                        UploadPhotoCard(
                          onRemoveTapped: () {
                            cubit.removePicture();
                          },
                          onButtonTapped: () {
                            cubit.pickImage(ImageSource.gallery);
                          },
                          onIconTapped: () async {
                            final XFile? image =
                                await context.push(Routes.cameraScreen);

                            if (image != null) {
                              cubit.selectedImage = image;
                            }
                          },
                          image: state is ReportSuccess
                              ? state.image
                              : cubit.selectedImage != null
                                  ? File(cubit.selectedImage!.path)
                                  : null,
                        ),
                        BiteOutlinedTextField(
                          controller: controller,
                          title: context.l10n!.email,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          onChange: (value) {
                            _validateEmail(value);
                          },
                          onFieldSubmitted: (value) {},
                          titleFontSize: 17,
                          titleFontWeight: FontWeight.w400,
                          titleTextColor: BiteColors.textColor,
                        ),
                        if (_emailValidator.isNotEmpty) ...[
                          BiteBodyB2Text(
                            text: context.l10n!.invalidFormat,
                            textColor: BiteColors.errorColor,
                          )
                        ],
                        BiteTextArea(
                          controller: textAreaController,
                          hintText: context.l10n!.reportProblemHintText,
                          hintTextColor: BiteColors.textColor,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: BiteFilledButton(
                            onPressed: controller.text.isEmpty ||
                                    cubit.selectedImage == null ||
                                    textAreaController.text.isEmpty
                                ? null
                                : () {
                                    cubit.startUploadImage(
                                      cubit.selectedImage ?? XFile(''),
                                      poiId ?? '',
                                      controller.text,
                                      textAreaController.text,
                                    );
                                  },
                            width: double.maxFinite,
                            text: context.l10n!.sendText,
                            prefixIconColor: BiteColors.black,
                            prefixIconName: 'icon_send',
                            leftPadding: 10,
                            rightPadding: 10,
                            topPadding: 10,
                            bottomPadding: 10,
                            borderRadius: 16,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
