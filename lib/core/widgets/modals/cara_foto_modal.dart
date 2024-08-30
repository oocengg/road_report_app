import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

Future<bool> showCaraFoto(BuildContext context) async {
  Completer<bool> completer = Completer<bool>();

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Cara Foto',
          style: TextStyle(
            fontSize: AppFontSize.bodyLarge,
            fontWeight: AppFontWeight.bodySemiBold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Berikut Cara foto yang benar!',
              style: TextStyle(
                fontSize: AppFontSize.bodyMedium,
                fontWeight: AppFontWeight.bodySemiBold,
              ),
            ),
            const Text(
              'Perhatikan cara foto yang benar, agar sistem dapat membaca gambar secara otomatis',
              style: TextStyle(
                fontSize: AppFontSize.bodySmall,
                fontWeight: AppFontWeight.bodyRegular,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // Display 2x2 photo grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Photo 1
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/salah1.png',
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                            color: AppColors.error50,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Tidak terlihat seluruh kerusakan',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Photo 2
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/benar1.png',
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                            color: AppColors.success50,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Benar',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 4,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Photo 1
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/salah2.png',
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                            color: AppColors.error50,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Bukan Jalan',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Photo 2
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/benar2.png',
                        height: MediaQuery.of(context).size.width * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        decoration: BoxDecoration(
                            color: AppColors.success50,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(
                          child: Text(
                            'Benar',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text("Batal"),
            onPressed: () {
              // Kembali ke layar sebelumnya tanpa menjalankan operasi
              Navigator.of(context).pop(false);
              completer.complete(false);
            },
          ),
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll(AppColors.primary500)),
            onPressed: () {
              // Tutup dialog dan set proceed menjadi true
              Navigator.of(context).pop(true);
              completer.complete(true);
            },
            child: const Text(
              "Mengerti",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
  return completer.future;
}
