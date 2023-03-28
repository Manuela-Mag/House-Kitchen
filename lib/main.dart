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
    return MultiBlocProvider(
        providers: [
        BlocProvider(create: (context) => MealBloc(MealRepository())..add(LoadCategory())),
        // BlocProvider(create: (context) => MealBloc(MealRepository())..add(LoadMeal())),
    ],
    child:MaterialApp(
        home: RepositoryProvider(
          create: (context) => MealRepository(),
          child: const MyHomePage(title: 'House Kitchen'),
        )
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory = 'beef';
  int selectedIndex = 0;
  List<Widget> cards = [];

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index, String category) {
    setState(() {
      print(category);
      print(index);
      selectedIndex = index;
      selectedCategory = category;
    });
  }

  // final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    //use only one block?

    return
    // MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (context) =>
    //     MealBloc(RepositoryProvider.of<MealRepository>(context),
    //     )
    //       ..add(LoadMeal())),
    //     BlocProvider(create: (context) =>
    //     CategoryBloc(RepositoryProvider.of<MealRepository>(context),
    //     )
    //       ..add(LoadCategory()))
    //   ],
    //   child:
      Scaffold(
        appBar: AppBar(
          title: const Text('House Kitchen'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "All Categories",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )],
              ),
            ),
            BlocBuilder<MealBloc, MealState>(
              builder: (context, state) {
                if (state is MealLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoadedState) {
                  List<CategoryModel> categories = state.categories;
                  //context.read<PizzaBloc>().add(AddPizza((Pizza.pizzas[0]))); to move to next state
                  return
                    Card(
                      color: Colors.white60,
                      child: SizedBox(
                        height: 110,
                        child: PageView.builder(
                        itemCount: 5,
                        onPageChanged: (index) {
                          pageChanged(index, categories[index].name);
                        },
                        // onPageChanged: (int index) => setState(() => {i = index}),
                        itemBuilder: (_, i) {
                          // Constants.CategoryHighlighted =
                          // Constants.itemCategory[_index]["name"];
                          final selectedCategory = categories[i];

                          for (int j = i; j < categories.length; j++) {
                            final selectedCategory = categories[j];
                            cards.add(
                              GestureDetector(
                                onTap: () {
                                  setState((){
                                    print(this.selectedCategory);
                                    this.selectedCategory = categories[j].name;
                                    selectedIndex = j;
                                    context.read<MealBloc>().add(LoadMeal(this.selectedCategory));
                                    print(this.selectedCategory);
                                  });
                                },
                                child: Card(
                                  elevation: 6,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: selectedIndex == j ? const BorderSide(color: Colors.black, width: 2.0) : BorderSide.none
                                  ),
                                  color: Colors.white,
                                  child: Container(
                                    width: 90,
                                    height: 100,
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child: Column(
                                      children: [
                                        Image.network(
                                          selectedCategory.image,
                                          height: 50,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Text(
                                            selectedCategory.name,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          print("list view");
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: cards,
                          );
                        },
                          ),
                      ),
                    );
                }
                print(state);
                if (state is MealLoadedState) {
                  List<MealModel> mealsList = state.meals;
                  return Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: cards
                        ),
                      ),
                      Container(
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
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      );
  }
}
