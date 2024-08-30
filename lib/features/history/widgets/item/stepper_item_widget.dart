import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';

// ignore: must_be_immutable
class StepperItemWidget extends StatelessWidget {
  final int index;
  final String title;
  final int currentIndex;
  final VoidCallback onTap;
  bool isLast;
  StepperItemWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.isLast = false,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //this is the bubble
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: index == currentIndex
                        ? AppColors.primary500
                        : AppColors.primary200,
                  ),
                ),
              ),
              // isLast
              //     ? const SizedBox.shrink()
              //     : Container(
              //         height: 2,
              //         color: AppColors.primary200,
              //       ),
            ],
          ),
          //index+1 we dont wanna show 0 in the screen since our index will start at 0
          Text(
            title,
          ),
        ],
      ),
    );

    // -------------------------------------------------------------------

    // return isLast
    //     ? Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               //this is the bubble
    //               GestureDetector(
    //                 onTap: onTap,
    //                 child: Container(
    //                   width: 12,
    //                   height: 12,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(100),
    //                     color: index == currentIndex
    //                         ? AppColors.primary500
    //                         : AppColors.primary200,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           //index+1 we dont wanna show 0 in the screen since our index will start at 0
    //           Text('Page ${index + 1}'),
    //         ],
    //       )
    //     : Expanded(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 //this is the bubble
    //                 GestureDetector(
    //                   onTap: onTap,
    //                   child: Container(
    //                     width: 12,
    //                     height: 12,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(100),
    //                       color: index == currentIndex
    //                           ? AppColors.primary500
    //                           : AppColors.primary200,
    //                     ),
    //                   ),
    //                 ),
    //                 //this the ligne
    //                 Expanded(
    //                   child: Container(
    //                     height: 2,
    //                     color: AppColors.primary200,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             //index+1 we dont wanna show 0 in the screen since our index will start at 0
    //             Text('Page ${index + 1}'),
    //           ],
    //         ),
    //       );
  }
}
