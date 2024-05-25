import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zlp_jokes/core/constants.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/text_styles.dart';

class SimpleJokeCard extends StatelessWidget {
  final JokeModel jokeModel;

  const SimpleJokeCard({super.key, required this.jokeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      jokeModel.rating.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/joke/${jokeModel.id}');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  jokeModel.text,
                  style: TextStyles.defaultJokeStyle,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: '${Constants.baseUrl}/joke/${jokeModel.id}'));
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
                IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: jokeModel.text));
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
    );
  }
}
