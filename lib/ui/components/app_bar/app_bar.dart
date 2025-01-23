import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_title_h2.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:flutter/material.dart';

class BiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;
  final Function onIconTap;

  const BiteAppBar({
    super.key,
    required this.onIconTap,
    this.title = '',
    this.backgroundColor = BiteColors.bgColor,
    this.actions = const [],
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              onIconTap();
            },
            icon: const BiteIcon(
              iconName: 'icon_chevron_left',
              margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
            ),
          ),
          Expanded(
            child: BiteTitleH2Text(
              text: title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 24,
          )
        ],
      ),
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: automaticallyImplyLeading,
      titleSpacing: 0,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
