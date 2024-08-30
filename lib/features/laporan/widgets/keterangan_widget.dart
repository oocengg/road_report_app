import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/features/laporan/widgets/item/keterangan_item_widget.dart';

class KeteranganWidget extends StatelessWidget {
  const KeteranganWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [
          KeteranganItemWidget(
            color: Colors.deepPurple,
            text: '18 DALAM PROSES',
          ),
          SizedBox(height: 8),
          KeteranganItemWidget(
            color: Colors.orange,
            text: '10 DITINDAK LANJUTI',
          ),
          SizedBox(height: 8),
          KeteranganItemWidget(
            color: Colors.blueAccent,
            text: '2 PERBAIKAN',
          ),
          SizedBox(height: 8),
          KeteranganItemWidget(
            color: Colors.greenAccent,
            text: '6 SELESAI',
          ),
        ],
      ),
    );
  }
}
