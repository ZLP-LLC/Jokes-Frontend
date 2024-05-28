import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/core/constants.dart';
import 'package:zlp_jokes/domain/jokes/models/annotated_joke_model.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/joke_screen_cubit.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/annotation_view.dart';
import 'package:zlp_jokes/features/joke_screen/widgets/rating_widget.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class JokeCard extends StatefulWidget {
  final AnnotatedJokeModel annotatedJokeModel;

  const JokeCard({super.key, required this.annotatedJokeModel});

  @override
  State<JokeCard> createState() => _JokeCardState();
}

class _JokeCardState extends State<JokeCard> {
  late bool _isAuthorized;
  late bool _notRated;

  @override
  void initState() {
    super.initState();
    _isAuthorized = false;
    _notRated = true;
    context.read<AuthCubit>().isAuthorized().then((value) {
      setState(() {
        _isAuthorized = value;
      });
    });

    setState(() {
      _notRated = context.read<JokeScreenCubit>().notRated;
    });
  }

  List<TextSpan> spansGenerator(AnnotatedJokeModel model) {
    List<TextSpan> textSpans = [];
    for (var element in model.jokeParts) {
      if (element.annotation == null) {
        textSpans.add(
          TextSpan(
            text: element.text,
            style: TextStyles.defaultJokeStyle,
          ),
        );
      } else {
        textSpans.add(
          TextSpan(
            text: element.text,
            style: TextStyles.annotationStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return AnnotationView(
                      text: element.annotation!,
                    );
                  },
                );
              },
          ),
        );
      }
    }
    return textSpans;
  }

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
                          widget.annotatedJokeModel.jokeModel.rating.toStringAsFixed(2),
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
                    TextSpan(children: [...spansGenerator(widget.annotatedJokeModel)]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: '${Constants.baseUrl}/joke/${widget.annotatedJokeModel.jokeModel.id}'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Ссылка скопирована'),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.share,
                        color: AppColors.color900,
                        size: 28,
                      ),
                    ),
                    if (_isAuthorized && _notRated)
                      SizedBox(
                        width: 160,
                        height: 40,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            side: WidgetStateProperty.all(
                              const BorderSide(
                                color: AppColors.color400,
                                width: 2.5,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            final result = await showDialog(
                              barrierColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) => RatingWidget(
                                jokeId: widget.annotatedJokeModel.jokeModel.id,
                              ),
                            );
                            if (result != null) {
                              context.read<JokeScreenCubit>().rate();
                              context.read<JokeScreenCubit>().loadJoke(
                                    widget.annotatedJokeModel.jokeModel.id,
                                  );
                            }
                          },
                          child: const Text(
                            'Оценить',
                            style: TextStyle(
                              color: AppColors.color800,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (_isAuthorized && !_notRated)
                      const Text(
                        'Спасибо за оценку!',
                        style: TextStyle(
                          color: AppColors.color800,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: widget.annotatedJokeModel.plainText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            duration: Duration(seconds: 1),
                            content: Text('Текст скопирован'),
                          ),
                        );
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
      ],
    );
  }
}
