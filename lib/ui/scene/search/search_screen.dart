import 'package:bite/extension/l10n_extension.dart';
import 'package:bite/models/responses/poi/detail/poi_detail.dart';
import 'package:bite/ui/components/communications/progress_indicator.dart';
import 'package:bite/ui/components/containers/search_result_card.dart';
import 'package:bite/ui/components/icon/icon.dart';
import 'package:bite/ui/components/text/text_button_regular.dart';
import 'package:bite/ui/scene/tabs/routes/components/search_bar.dart';
import 'package:bite/ui/themes/bite_colors.dart';
import 'package:bite/ui/themes/bite_text.dart';
import 'package:bite/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bite/ui/scene/search/bloc/search_state.dart';
import 'package:bite/ui/scene/search/bloc/search_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  double? latitude;
  double? longitude;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? extraParams =
        GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (extraParams != null) {
      searchController.text = extraParams['searchText'] as String? ?? '';
      latitude = extraParams['latitude'] as double?;
      longitude = extraParams['longitude'] as double?;
    }

    return Container(
      color: BiteColors.bgColor,
      child: BlocProvider(
        create: (context) => SearchCubit(
          searchController.text,
          latitude ?? 90,
          longitude ?? 90,
        ),
        child: BlocListener<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchError) {
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
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              final cubit = context.read<SearchCubit>();

              if (state is SearchLoading) {
                return const Center(
                  child: BiteProgressIndicator(
                    type: BiteProgressIndicatorType.circular,
                  ),
                );
              }

              return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 24, 24),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const BiteIcon(
                                iconName: 'icon_chevron_left',
                              ),
                            ),
                            Flexible(
                              child: BiteRoutesSearchBar(
                                controller: searchController,
                                hintText: context.l10n!.searchPOI,
                                bgColor: BiteColors.primaryColor,
                                hintTextColor: BiteColors.textColor,
                                onChanged: (query) async {
                                  if (query.length > 2) {
                                    await cubit.fullTextSearch(
                                      query,
                                      1,
                                      90,
                                      90,
                                    );

                                    cubit.updateCurrentPage(1, query);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state is SearchSuccess)
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: RichText(
                              text: TextSpan(
                                text:
                                    cubit.searchResults?.totalCount.toString(),
                                style: const TextStyle(
                                  color: BiteColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Urbanist',
                                ),
                                children: [
                                  const WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 4),
                                    ),
                                  ),
                                  TextSpan(
                                    text: context.l10n!.poiCount,
                                    style: biteTextTheme.bodySmall!
                                        .apply(color: BiteColors.textColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: PagedListView<int, PoiDetail>(
                          shrinkWrap: true,
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
                          pagingController: cubit.pagingController,
                          builderDelegate: PagedChildBuilderDelegate<PoiDetail>(
                            itemBuilder: (context, item, index) {
                              return SearchResultCard(
                                result: item,
                                isSearchScreen: true,
                                drawBottomBorder: index % 2 == 0 ? false : true,
                              );
                            },
                            noItemsFoundIndicatorBuilder: (context) => Center(
                              child: BiteButtonRegularText(
                                text: context.l10n!.noItemsFound,
                              ),
                            ),
                            firstPageProgressIndicatorBuilder: (context) =>
                                const Center(
                                    child: BiteProgressIndicator(
                              type: BiteProgressIndicatorType.circular,
                            )),
                            newPageProgressIndicatorBuilder: (context) =>
                                const Center(
                                    child: BiteProgressIndicator(
                              type: BiteProgressIndicatorType.circular,
                            )),
                          ),
                        ),
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
