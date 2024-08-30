import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/features/profile/widgets/item/information_item_widget.dart';

class InformationWidget extends StatefulWidget {
  final String nama;
  final String alamat;
  final String noHp;
  const InformationWidget(
      {super.key,
      required this.nama,
      required this.alamat,
      required this.noHp});

  @override
  State<InformationWidget> createState() => _InformationWidgetState();
}

class _InformationWidgetState extends State<InformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationItemWidget(
          title: 'Nama',
          value: widget.nama,
        ),
        const SizedBox(
          height: 12,
        ),
        InformationItemWidget(
          title: 'Alamat',
          value: widget.alamat,
        ),
        const SizedBox(
          height: 12,
        ),
        InformationItemWidget(
          title: 'Nomor Ponsel',
          value: widget.noHp,
        ),
        // const SizedBox(
        //   height: 12,
        // ),
        // const InformationItemWidget(
        //   title: 'Negara',
        //   value: 'Indonesia',
        // ),
        // const SizedBox(
        //   height: 12,
        // ),
        // const InformationItemWidget(
        //   title: 'Zona Waktu',
        //   value: 'Jakarta, Indonesia',
        // ),
      ],
    );
  }
}
