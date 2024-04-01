import 'package:flutter/material.dart';
import 'package:jbfr_april_fp/features/home/home_controller.dart';
import 'package:jbfr_april_fp/features/home/home_model.dart';

class HomePage extends StatefulWidget {
  static const String route = '/route';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;

  @override
  void initState() {
    HomeController().retrieveData().then((value) => setState(() {
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildTabBar(),
          Expanded(
            child: HomeTab.availableHomeTabs[selectedPage].page(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: Theme.of(context).colorScheme.shadow,
      child: Column(
          children: List.generate(
              HomeTab.availableHomeTabs.length,
              (index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedPage = index;
                      });
                    },
                    child: Container(
                        color: index == selectedPage ? Colors.blue : Colors.transparent,
                        child: Padding(
                            padding: const EdgeInsets.all(32.0), child: Icon(HomeTab.availableHomeTabs[index].icon, size: 32,))),
                  ))..addAll([Expanded(child: Container()), Text("JackBlock OS")])),
    );
  }
}
