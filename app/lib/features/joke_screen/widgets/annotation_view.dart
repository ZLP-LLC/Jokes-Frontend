import 'package:flutter/material.dart';
import 'package:link_text/link_text.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class AnnotationView extends StatelessWidget {
  final String text;
  const AnnotationView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Flexible(flex: 1, child: SizedBox.shrink()),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.color300,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: AppColors.color900,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinkText(
                        text,
                        linkStyle: TextStyles.defaultJokeStyle.copyWith(color: Colors.blue),
                        textStyle: TextStyles.defaultJokeStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
