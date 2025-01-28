import 'package:flutter/material.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/ui/News/News_Widget.dart';
import 'package:news_route/ui/category_details/category_details_viewmodel.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:provider/provider.dart';

class SourceTabWidget extends StatefulWidget {
  SourceTabWidget({
    super.key,
    required this.sourceList,
  });

  final List<Source>? sourceList;

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget> {
  //int selectedIndex = 0;
  CategoryDetailsViewmodel categoryDetailsViewmodel =
      CategoryDetailsViewmodel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => categoryDetailsViewmodel,
      child: Consumer(
        builder: (context, CategoryDetailsViewmodel, child) {
          return Column(
            children: [
              DefaultTabController(
                length: widget.sourceList!.length,
                child: TabBar(
                    onTap: (index) {
                      categoryDetailsViewmodel.changeIndex(index);
                      print("index $index");
                      print("sindex ${categoryDetailsViewmodel.selectedIndex}");
                      print("ss${widget.sourceList!.indexOf(Source())}");
                    },
                    dividerColor: Colors.transparent,
                    tabAlignment: TabAlignment.start,
                    isScrollable: true,
                    indicatorColor: Theme.of(context).indicatorColor,
                    tabs: widget.sourceList!.map((source) {
                      return Text(source.name ?? "",
                          style: categoryDetailsViewmodel.selectedIndex ==
                                  widget.sourceList!.indexOf(source)
                              ? AppStyle.bold16White.copyWith(
                                  color: Theme.of(context).indicatorColor)
                              : AppStyle.Medium14White.copyWith(
                                  color: Theme.of(context).indicatorColor));
                    }).toList()),
              ),
              Expanded(
                  child: NewsWidget(
                      source: widget
                          .sourceList![categoryDetailsViewmodel.selectedIndex]))
            ],
          );
        },
        /*  child: Column(
          children: [
            DefaultTabController(
              length: widget.sourceList!.length,
              child: TabBar(
                  onTap: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).indicatorColor,
                  tabs: widget.sourceList!.map((source) {
                    return Text(source.name ?? "",
                        style:
                            selectedIndex == widget.sourceList!.indexOf(source)
                                ? AppStyle.bold16White.copyWith(
                                    color: Theme.of(context).indicatorColor)
                                : AppStyle.Medium14White.copyWith(
                                    color: Theme.of(context).indicatorColor));
                  }).toList()),
            ),
            Expanded(
                child: NewsWidget(source: widget.sourceList![selectedIndex]))
          ],*/
      ),
    );
  }
}
