import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/features/joke_screen/bloc/rating_screen_cubit.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class RatingWidget extends StatefulWidget {
  final int jokeId;
  const RatingWidget({super.key, required this.jokeId});

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RatingScreenCubit(),
      child: BlocBuilder<RatingScreenCubit, AppState>(
        builder: (context, state) {
          return Dialog(
            child: Container(
              height: 260,
              width: 300,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Оцените анекдот',
                      style: TextStyle(
                        color: AppColors.color200,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _sliderValue.toString(),
                      style: const TextStyle(
                        color: AppColors.color200,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 1,
                      divisions: 10000,
                      activeColor: AppColors.color400,
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 160,
                      height: 44,
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
                          await context.read<RatingScreenCubit>().rateJoke(
                                jokeId: widget.jokeId,
                                rating: _sliderValue,
                              );
                          Navigator.of(context).pop(true);
                        },
                        child: const Text(
                          'Оценить',
                          style: TextStyle(
                            color: AppColors.color200,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
