import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zlp_jokes/domain/jokes/models/joke_model.dart';
import 'package:zlp_jokes/features/auth/bloc/auth_cubit.dart';
import 'package:zlp_jokes/features/home/bloc/home_screen_cubit.dart';
import 'package:zlp_jokes/features/home/grid_screen/widgets/grid_screen.dart';
import 'package:zlp_jokes/utils/app_colors.dart';
import 'package:zlp_jokes/utils/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<JokeModel> _jokes = [];
  List<JokeModel> _jokesToShow = [];
  bool _showSearch = false;
  late TextEditingController _searchController;
  double _savedScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _showSearch
            ? Center(
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Поиск...',
                    hintStyle: const TextStyle(color: AppColors.color200, fontSize: 18),
                    filled: false,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _jokesToShow = _jokes;
                          _showSearch = false;
                        });
                      },
                      icon: const Icon(Icons.close),
                      color: AppColors.color200,
                    ),
                  ),
                  style: const TextStyle(color: AppColors.color200),
                  onChanged: (value) {
                    setState(() {
                      _jokesToShow = _jokes.where((joke) {
                        return joke.text.toLowerCase().contains(value.toLowerCase());
                      }).toList();
                    });
                  },
                ),
              )
            : const Text(
                'Анекдоты',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28, color: AppColors.color200),
              ),
        actions: [
          if (!_showSearch)
            IconButton(
              onPressed: () {
                setState(() {
                  _showSearch = true;
                });
              },
              icon: const Icon(Icons.search),
            ),
          BlocBuilder<HomeScreenCubit, AppState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () async {
                  final bool isAuthorized = await context.read<AuthCubit>().isAuthorized();
                  Navigator.pushNamed(
                    context,
                    isAuthorized ? '/account' : '/auth',
                  );
                },
                icon: const Icon(Icons.account_circle),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeScreenCubit, AppState>(
        builder: (context, state) {
          if (state is AppStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AppStateSuccess<List<JokeModel>>) {
            _jokes = state.data!;
            if (!_showSearch) _jokesToShow = _jokes;
            return GridScreen(
              jokes: _jokesToShow,
              savedScrollPosition: _savedScrollPosition,
              onScrollPositionChanged: (position) {
                _savedScrollPosition = position;
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
