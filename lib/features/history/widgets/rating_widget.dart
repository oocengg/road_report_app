import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';
import 'package:mobileapp_roadreport/core/state/finite_state.dart';
import 'package:mobileapp_roadreport/features/history/provider/detail_history_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/colors.dart';

class RatingWidget extends StatefulWidget {
  final int rating;
  final String saran;
  const RatingWidget({super.key, required this.rating, required this.saran});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  @override
  Widget build(BuildContext context) {
    final detailProvider =
        Provider.of<DetailHistoryProvider>(context, listen: false);
    return Column(
      children: [
        const Text(
          //"Terima kasih telah menggunakan aplikasi kami, kini jalan yang anda laporkan sudah kami perbaiki. Silahkan memberikan penilaian anda terhadap kinerja kami",
          "Penilaian anda sangat kami hargai",
          style: TextStyle(
            fontSize: AppFontSize.bodyMedium,
            fontWeight: AppFontWeight.bodySemiBold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RatingBar.builder(
          initialRating: widget.rating.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          ignoreGestures: widget.rating == 0 ? false : true,
          onRatingUpdate: (rating) {
            detailProvider.rating = rating;
          },
        ),
        const SizedBox(
          height: 10,
        ),
        detailProvider.detail[0].rating == null ||
                detailProvider.detail[0].rating!.rate == 0
            ? TextFormField(
                enabled: widget.rating == 0 ? true : false,
                controller: detailProvider.saranController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                maxLines: 5,
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  border: Theme.of(context).inputDecorationTheme.border,
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.neutral300,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.neutral300,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primary500,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  hintText: "Kritik dan saran",
                  hintStyle: const TextStyle(
                    fontWeight: AppFontWeight.bodyRegular,
                    fontSize: AppFontSize.bodySmall,
                    color: AppColors.neutral600,
                  ),
                ),
              )
            : Center(
                child: detailProvider.detail[0].rating!.comment != null &&
                        detailProvider.detail[0].rating!.comment != ''
                    ? Text(
                        "'' ${detailProvider.detail[0].rating!.comment ?? ""} ''",
                        style: const TextStyle(
                          fontSize: AppFontSize.bodyMedium,
                          fontWeight: AppFontWeight.bodyRegular,
                        ),
                      )
                    : const SizedBox.shrink()),
        const SizedBox(
          height: 10,
        ),
        detailProvider.detail[0].rating == null ||
                detailProvider.detail[0].rating!.rate == 0
            ? InkWell(
                onTap: () async {
                  if (detailProvider.rating != 0) {
                    await detailProvider.postRating();
                    if (context.mounted) {
                      if (detailProvider.ratingState == MyState.loaded) {
                        context
                            .read<DetailHistoryProvider>()
                            .getData(context, detailProvider.detail[0].id!);
                      }
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Row(
                          children: [
                            Icon(
                              FeatherIcons.xCircle,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Text(
                                'Maaf, rating tidak boleh kosong.',
                              ),
                            ),
                          ],
                        ),
                        backgroundColor: AppColors.error500,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.primary500),
                  child: detailProvider.ratingState == MyState.loading
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          "Kirim",
                          style: TextStyle(
                            fontSize: AppFontSize.bodyMedium,
                            fontWeight: AppFontWeight.bodySemiBold,
                            color: Colors.white,
                          ),
                        ),
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
