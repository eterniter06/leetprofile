import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';
import 'package:ui_elements/providers/theme.dart';
import 'language_card.dart';

class LanguageSection extends StatefulWidget implements ClassName {
  const LanguageSection({super.key, required this.languageProblemList});
  final List<LanguageSubmission> languageProblemList;

  @override
  State<LanguageSection> createState() => _LanguageSectionState();

  @override
  String className() {
    return 'LanguageSection';
  }
}

class _LanguageSectionState extends State<LanguageSection>
    with TickerProviderStateMixin {
  late ScrollController scrollController;

  bool isScrollable = false;

  late final AnimationController animationController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: animationController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    // Todo: Figure out a more reliable way to detect if list is scrollable
    // Source: https://stackoverflow.com/questions/65358691/how-to-know-if-list-view-is-scrollable-programatically
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.position.maxScrollExtent > 0) {
        setState(() {
          isScrollable = true;

          scrollController.addListener(() {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              animationController.forward();
            }
            if (animationController.isCompleted) {
              animationController.reverse();
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  void scrollForward() {
    scrollController.animateTo(
      scrollController.position.pixels +
          MediaQuery.of(context).size.width / 2.2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
  }

  void scrollToStart() {
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastEaseInToSlowEaseOut);
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      header: 'Languages',
      trailer: isScrollable
          ? Consumer<ThemeModeModel>(
              builder: (context, themeModel, child) => IconButton(
                icon: RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
                  child: Icon(
                    Icons.double_arrow_rounded,
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                tooltip: 'Scroll languages',
                onPressed: () => scrollController.position.extentAfter > 0
                    ? scrollForward()
                    : scrollToStart(),
              ),
            )
          : null,
      children: [
        SizedBox(
          height: 140,
          child: ListView.builder(
            controller: scrollController,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.languageProblemList.length,
            itemBuilder: (BuildContext context, int index) => LanguageCard(
              languageDetails: widget.languageProblemList[index],
            ),
          ),
        ),
      ],
    );
  }
}
