import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/features/history/provider/history_provider.dart';
import 'package:uicons/uicons.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(
      builder: (context, provider, _) {
        return Form(
            key: provider.formKey,
            child: TextFormField(
              onFieldSubmitted: (value) async {
                if (provider.searchController.text.isEmpty) {
                  context.read<HistoryProvider>().resetCurrentPage();
                  await provider.getData(context);
                } else {
                  await provider.search(context);
                }
              },
              controller: provider.searchController,
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                prefixIcon: Icon(
                  UIcons.regularStraight.search,
                  color: AppColors.neutral300,
                ),
                border: Theme.of(context).inputDecorationTheme.border,
                errorStyle: const TextStyle(
                  color: Colors.red,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.neutral300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.indigo,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Cari No. Tiketmu",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: AppColors.neutral300,
                ),
              ),
              onChanged: (value) {
                // Perform search operations here based on the search value (value)
              },
            ));
      },
    );
    // Container(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    //     width: double.infinity,
    //     height: 48,
    //     decoration: BoxDecoration(
    //       border: Border.all(
    //         color: AppColors.grey300,
    //       ),
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child:
    //     // Row(
    //     //   children: [
    //     //     Icon(
    //     //       UIcons.regularStraight.search,
    //     //       color: AppColors.grey300,
    //     //     ),
    //     //     const SizedBox(width: 16),
    //     //   ],
    //     // ),
    //     );
  }
}
