import 'package:flutter/material.dart';
import 'package:ui_elements/dataclass/user_class/userdata.dart';
import 'package:ui_elements/common_components/interfaces.dart';
import 'package:ui_elements/pages/profile/components/profile_card.dart';
import 'package:ui_elements/pages/profile/components/trailing_scroll_button.dart';
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

class _LanguageSectionState extends State<LanguageSection> {
  late ScrollController scrollController;

  bool isScrollable = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (scrollController.position.maxScrollExtent > 0) {
        setState(() {
          isScrollable = true;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      header: 'Languages',
      trailer: isScrollable
          ? TrailingScrollButton(scrollController: scrollController)
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
