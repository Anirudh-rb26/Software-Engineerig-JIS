import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackbar extends StatelessWidget {
  final bool success;
  final String errorText;
  Color? snackBarColor;
  CustomSnackbar({
    super.key,
    required this.errorText,
    required this.snackBarColor,
    required this.success,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
              color: snackBarColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              const SizedBox(width: 48),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    success
                        ? const Text(
                            "Success!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Oh Snap!",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                    const Spacer(),
                    Text(
                      errorText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 0,
        //   child: ClipRRect(
        //     borderRadius:
        //         const BorderRadius.only(bottomLeft: Radius.circular(12)),
        //     child: SvgPicture.asset(
        //       "assets/icons/bubbles.svg",
        //       height: 48,
        //       width: 40,
        //       color: const Color(0xFF801336),
        //     ),
        //   ),
        // ),
        // Positioned(
        //   top: -20,
        //   left: 0,
        //   child: Stack(
        //     alignment: Alignment.center,
        //     children: [
        //       SvgPicture.asset(
        //         "assets/icons/fail.svg",
        //         height: 40,
        //       ),
        //       Positioned(
        //         top: 10,
        //         child: SvgPicture.asset(
        //           "assets/icons/close.svg",
        //           height: 16,
        //         ),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }
}
