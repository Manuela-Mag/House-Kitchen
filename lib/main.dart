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
  List<Widget> cards = <Widget>[];

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index, String category) {
    setState(() {
      selectedIndex = index;
      selectedCategory = category;
    });
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
              padding: const EdgeInsets.all(15.0),
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
                      onPageChanged: (int index) {
                        pageChanged(index, categories[index].name);
                      },
                      itemBuilder: (_, int i) {
                        for (int j = i; j < categories.length; j++) {
                          final CategoryModel selectedCategory = categories[j];
                          cards.add(
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  this.selectedCategory = categories[j].name;
                                  selectedIndex = j;
                                  context
                                      .read<MealBloc>()
                                      .add(LoadMeal(this.selectedCategory));
                                });
                              },
                              child: Card(
                                elevation: 6,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    side: selectedIndex == j || j == 0
                                        ? const BorderSide(
                                            color: Colors.black, width: 2.0)
                                        : BorderSide.none),
                                color: Colors.white,
                                child: Container(
                                  width: 90,
                                  height: 100,
                                  margin: const EdgeInsets.only(top: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget> [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(
                                            20),
                                        child: Image.network(
                                          selectedCategory.image,
                                          height: 50,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
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
                        return ListView(
                            scrollDirection: Axis.horizontal, children: cards);
                      },
                    ),
                  ),
                );
              }
              if (state is MealLoadedState) {
                final List<MealModel> mealsList = state.meals;
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
                                            mainAxisSpacing: 5,),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: mealsList.length,
                                    itemBuilder: (_, int index) {
                                      return Card(
                                          color: Colors.white,
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          // margin: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              //     .spaceEvenly,
                                              children: <Widget> [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    // Image border
                                                    child: Image.network(
                                                      mealsList[index].image,
                                                      // width: 180,
                                                      height: 110,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    mealsList[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontFamily: 'Manrope'),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0, top: 5),
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
                                                        fontFamily: 'Manrope'),
                                                  ),
                                                ),
                                              ]));
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Container(
                color: Colors.green,
              );
            },
          ),
        ],
      ),
    );
  }
}
