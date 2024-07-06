import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/assets/assets.gen.dart';
import 'package:news_app/core/constants/styles.dart';

class InitPage extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const InitPage({super.key, required this.navigationShell});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int selectedIndex = 0;
  void _goToBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: blackColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              width: 24,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
                _goToBranch(selectedIndex);
              },
              child: SizedBox(
                height: 24,
                width: 24,
                child: SvgPicture.asset(
                  selectedIndex == 0
                      ? Assets.icons.houseSolid.path
                      : Assets.icons.house.path,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
                _goToBranch(selectedIndex);
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  selectedIndex == 1
                      ? Assets.icons.bookmarkSolid.path
                      : Assets.icons.bookmark.path,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 2;
                });
                _goToBranch(selectedIndex);
              },
              child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  selectedIndex == 2
                      ? Assets.icons.userSolid.path
                      : Assets.icons.user.path,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
