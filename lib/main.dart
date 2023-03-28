import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_house/blocs/category/category_bloc.dart';
import 'package:kitchen_house/models/category_model.dart';
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
          child: const Home(),
        )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    //use only one block?

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        MealBloc(RepositoryProvider.of<MealRepository>(context),
        )
          ..add(LoadMeal())),
        BlocProvider(create: (context) =>
        CategoryBloc(RepositoryProvider.of<MealRepository>(context),
        )
          ..add(LoadCategory()))
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('House Kitchen'),
        ),
        body: Column(
          children: [
            const Text("All categories"),
            BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MealLoadedState) {
                  List<MealModel> mealsList = state.meals;
                  return Container(
                    color: Colors.black12,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Flexible(
                          child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  // childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 5
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: mealsList.length,
                              itemBuilder: (_, index) {
                                return Card(
                                    color: Colors.white,
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    // margin: const EdgeInsets.symmetric(vertical: 10),
                                    child: Column(
                                        // mainAxisAlignment: MainAxisAlignment
                                        //     .spaceEvenly,
                                        children: [
                                          Image.network(
                                            mealsList[index].image,
                                            // width: 140,
                                            // height: 140,
                                          ),
                                          SizedBox(
                                              // height: 40,
                                              // width: 140,
                                              child: Text(mealsList[index].name))
                                        ])
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
