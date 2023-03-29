import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitchen_house/models/category_model.dart';
import 'package:kitchen_house/repos/meal_repo.dart';
import 'blocs/meal/meal_bloc.dart';
import 'custom_widgets/custom_collapsible.dart';
import 'models/meal_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: <BlocProvider<Bloc<dynamic, dynamic>>> [
          BlocProvider <MealBloc> (
              create: (BuildContext context) =>
                  MealBloc(MealRepository())..add(LoadCategory())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.red,
              fontFamily: 'Poppins'
            ),
            home: RepositoryProvider<MealRepository> (
              create: (BuildContext context) => MealRepository(),
              child: const MyHomePage(),
            )));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedCategory = 'Beef';
  int selectedIndex = 0;
  int chosen = 0;
  List<Widget> cards = <Widget>[];
  List<CategoryModel> categoriesList = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    cards = <Widget>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Image.asset(
          'assets/title.png'
        )
      ),
      body: Column(
        children: <Widget> [
          const CustomCollapsible(),
          Container(
            color: const Color(0xFDD3D3D3),
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10.0, bottom: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget> [
                  Text(
                    'All Categories',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                ],
              ),
            ),
          ),
          BlocBuilder<MealBloc, MealState>(
            builder: (BuildContext context, MealState state) {
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
                final List<CategoryModel> categories = state.categories;
                context.read<MealBloc>().add(LoadMeal(selectedCategory));
                return Card(
                  color: Colors.white10,
                  child: SizedBox(
                    height: 110,
                    child: PageView.builder(
                      itemCount: 5,
                      itemBuilder: (_, int i) {
                        for (int j = i; j < categories.length; j++) {
                          categoriesList = categories;
                          cards = getListOfCards(categories, selectedIndex);
                        }
                        return ListView(
                            scrollDirection: Axis.horizontal, children: cards);
                      },
                    ),
                  ),
                );
              }
              if (state is MealLoadedState) {
                final List<MealModel> mealsList = state.meals;
                cards = getListOfCards(categoriesList, chosen);
                return Column(
                  children: <Widget> [
                    Container(
                      color: const Color(0xFDD3D3D3),
                      child: SizedBox(
                        height: 110,
                        child: ListView(
                            scrollDirection: Axis.horizontal, children: cards),
                      ),
                    ),
                    Container(
                      color: const Color(0xFDD3D3D3),
                      height: 10,
                    ),
                    Container(
                      color: const Color(0xFDD3D3D3),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: SizedBox(
                          height: 450,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                              Expanded(
                                child: Container(
                                  color: const Color(0xFDD3D3D3),
                                  child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 200,
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: mealsList.length,
                                      itemBuilder: (_, int index) {
                                        return SizedBox(
                                          height:  MediaQuery.of(context).size.height * 0.4,
                                          child: Card(
                                              color: Colors.white,
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget> [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(left: 30.0, top: 10, ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        child: Image.network(
                                                          mealsList[index].image,
                                                          height: MediaQuery.of(context).size.height * 0.15,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0, top: 10),
                                                      child: Tooltip(
                                                        message: mealsList[index].name,
                                                        child: Text(
                                                          mealsList[index].name,
                                                          textAlign: TextAlign.start,
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                          textDirection: TextDirection.ltr,
                                                          style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight.w700),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 15.0, bottom: 5),
                                                      child: Text(
                                                        selectedCategory,
                                                        textAlign: TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FontStyle.italic,
                                                            color:
                                                                Color(0xFD9C9C9C),
                                                            fontFamily: 'Urbanist'),
                                                      ),
                                                    ),
                                                  ])),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return  const Text(
                'No data is available. Please try again later'
              );
            },
          ),
        ],
      ),
    );
  }


  List<Widget> getListOfCards(List<CategoryModel> categories, int selectedIndex) {
    final List<Widget> newCards =  <Widget>[];
    for (int j = 0; j < categories.length; j++) {
      final CategoryModel selectedCategoryItem = categories[j];
      newCards.add(GestureDetector(
          onTap: () {
            setState(() {
              selectedCategory = categories[j].name;
              chosen = j;
              context
                  .read<MealBloc>()
                  .add(LoadMeal(selectedCategory));
            });
          },
          child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: chosen == j
                  ? const BorderSide(
                  color: Colors.black, width: 2.0)
                  : const BorderSide(
              color: Colors.white, width: 2.0)),
        color: Colors.white,
        child: Container(
          width: 90,
          height: 100,
          margin: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ClipRRect(
                borderRadius:
                BorderRadius.circular(
                    20),
                child: Image.network(
                  selectedCategoryItem.image,
                  height: 50,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Tooltip(
                  message: selectedCategoryItem.name,
                  child: Text(
                    selectedCategoryItem.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),)
    );
    }
    return newCards;
  }
}
