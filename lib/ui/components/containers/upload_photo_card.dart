import 'dart:io';

import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/ui/components/actions/common_buttons/filled_button.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_body_b1.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadPhotoCard extends StatelessWidget {
  final Function onIconTapped;
  final Function onButtonTapped;
  final Function onRemoveTapped;
  final File? image;

  const UploadPhotoCard({
    super.key,
    required this.onIconTapped,
    required this.onButtonTapped,
    required this.onRemoveTapped,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(16),
      color: BiteColors.neutral1,
      dashPattern: const [3, 3],
      strokeWidth: 1.5,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.16,
        width: double.infinity,
        child: image != null
            ? Column(
                spacing: 8,
                children: [
                  Flexible(
                    child: Image.file(image!),
                  ),
                  BiteFilledButton(
                    topPadding: 4,
                    bottomPadding: 4,
                    leftPadding: 16,
                    rightPadding: 16,
                    width: null,
                    borderRadius: 32,
                    onPressed: () {
                      onRemoveTapped();
                    },
                    text: context.l10n?.removeLabel ?? '',
                    textFontWeight: FontWeight.w400,
                    textFontSize: 16,
                  )
                ],
              )
            : Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onIconTapped();
                    },
                    child: const BiteIcon(
                      iconName: 'icon_upload',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      onIconTapped();
                    },
                    child: BiteBodyB1Text(
                      text: context.l10n!.takeAPhoto,
                      textColor: BiteColors.neutral1,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    context.l10n!.orLabel,
                    style: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w400,
                      fontSize: 9,
                      color: BiteColors.neutral1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BiteFilledButton(
                    topPadding: 4,
                    bottomPadding: 4,
                    leftPadding: 16,
                    rightPadding: 16,
                    width: null,
                    borderRadius: 32,
                    onPressed: () {
                      onButtonTapped();
                    },
                    text: context.l10n!.browse,
                    textFontWeight: FontWeight.w400,
                    textFontSize: 16,
                  )
                ],
              ),
      ),
    );
  }
}
