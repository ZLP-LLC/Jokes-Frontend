import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/annotation_push_cubit.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class AnnotationPushWidget extends StatefulWidget {
  final String textToAnnotate;
  final int jokeId;
  final int textFrom;
  final int textTo;
  const AnnotationPushWidget({
    super.key,
    required this.textToAnnotate,
    required this.jokeId,
    required this.textFrom,
    required this.textTo,
  });

  @override
  State<AnnotationPushWidget> createState() => _AnnotationPushWidgetState();
}

class _AnnotationPushWidgetState extends State<AnnotationPushWidget> {
  late TextEditingController _annotationController;

  @override
  void initState() {
    super.initState();
    _annotationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnnotationPushCubit(),
      child: BlocBuilder<AnnotationPushCubit, AppState>(
        builder: (context, state) {
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
                        color: AppColors.color800,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                'Добавление аннотации',
                                style: TextStyle(
                                  color: AppColors.color200,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              widget.textToAnnotate,
                              style: TextStyles.defaultJokeStyle.copyWith(
                                color: AppColors.color200,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Material(
                              child: TextFormField(
                                controller: _annotationController,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: SizedBox(
                                width: 160,
                                height: 60,
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
                                    await context.read<AnnotationPushCubit>().pushAnnotation(
                                          jokeId: widget.jokeId,
                                          textFrom: widget.textFrom,
                                          textTo: widget.textTo,
                                          annotation: _annotationController.text,
                                        );
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text(
                                    textAlign: TextAlign.center,
                                    'Предложить\nаннотацию',
                                    style: TextStyle(
                                      color: AppColors.color200,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
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
        },
      ),
    );
  }
}
