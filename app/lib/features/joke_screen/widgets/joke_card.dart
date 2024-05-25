import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/constants.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/domain/jokes/models/annotated_joke_model.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/rating_widget.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class JokeCard extends StatefulWidget {
  final JokeModel jokeModel;

  const JokeCard({super.key, required this.jokeModel});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  // List<TextSpan> textSpans = [TextSpan()];

  late bool _isAuthorized;
  // latwidget.e JokeModel jokeModel;

  @override
  void initState() {
    // spansGenerator(jokeModel);
    super.initState();
    _isAuthorized = false;
    context.read<AuthCubit>().isAuthorized().then((value) {
      setState(() {
        _isAuthorized = value;
      });
    });
  }

  // void spansGenerator(AnnotatedJokeModel jokeModel) {

  //       if (jokeModel.annotation == null) {
  //         textSpans.add(TextSpan(text: element.text, style: defaultStyle));
  //       } else {
  //         textSpans.add(
  //           TextSpan(
  //             text: element.text,
  //             style: annotationStyle,
  //             recognizer: TapGestureRecognizer()
  //               ..onTap = () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) {
  //                     return Dialog(
  //                       child: Text(element.annotation!),
  //                     );
  //                   },
  //                 );
  //               },
  //           ),
  //         );
  //       }
  //     }
  //   }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.color200,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.color800,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: AppColors.color800,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                        child: Text(
                          widget.jokeModel.rating.toStringAsFixed(2),
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: SelectableText.rich(
                    TextSpan(text: widget.jokeModel.text, style: TextStyles.defaultJokeStyle),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: '${Constants.baseUrl}/joke/${widget.jokeModel.id}'),
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.color900,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: widget.jokeModel.text));
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: AppColors.color900,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isAuthorized) ...[
          const SizedBox(
            height: 20,
          ),
          const RatingWidget(),
        ],
      ],
    );
  }
}
