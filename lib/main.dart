import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_house/repos/meal_repo.dart';

import 'blocs/meal/meal_bloc.dart';
import 'models/meal_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House Kitchen',
      home: RepositoryProvider(
        create: (context) => MealRepository(),
        child:  const Home(),
      )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  // final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MealBloc(
          RepositoryProvider.of<MealRepository>(context),
        )..add(LoadMeal()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('House Kitchen'),
        ),
        body: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            if(state is MealLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is MealLoadedState) {
              List<MealModel> mealsList = state.meals;
              return ListView.builder(
                  itemCount: mealsList.length,
                  itemBuilder: (_, index) {
                    return Card(
                      color: Colors.blue,
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile (
                        title: Text(mealsList[index].name),
                      ),
                    );
                  });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
