import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

class FaqItemWidget extends StatefulWidget {
  final String title;
  final String data;
  const FaqItemWidget({super.key, required this.title, required this.data});

  @override
  State<FaqItemWidget> createState() => _FaqItemWidgetState();
}

class _FaqItemWidgetState extends State<FaqItemWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: isOpen ? AppColors.primary50 : Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(
            widget.title,
            style: TextStyle(
              fontWeight:
                  isOpen ? AppFontWeight.bodyBold : AppFontWeight.bodySemiBold,
              fontSize: AppFontSize.bodySmall,
              overflow: isOpen ? null : TextOverflow.ellipsis,
            ),
            maxLines: isOpen ? null : 1,
          ),
          onExpansionChanged: (value) {
            setState(() {
              isOpen = !isOpen;
            });
          },
          children: <Widget>[
            ListTile(
              title: Html(
                data: widget.data,
                style: {
                  'p': Style(textAlign: TextAlign.justify),
                  'ol': Style(
                    margin: Margins.symmetric(horizontal: 0, vertical: 0),
                    padding: HtmlPaddings.symmetric(
                      horizontal: 20,
                    ),
                  ),
                  'ul': Style(
                    margin: Margins.symmetric(horizontal: 0),
                    padding: HtmlPaddings.symmetric(
                      horizontal: 20,
                    ),
                  ),
                  'li': Style(textAlign: TextAlign.justify),
                },
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }
}
