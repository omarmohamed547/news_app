import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/di/di.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/ui/News/News_Widget.dart';
import 'package:news_route/ui/category_details/cubit/source_states.dart';
import 'package:news_route/ui/category_details/cubit/source_view_model.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:provider/provider.dart';

class SourceTabWidget extends StatefulWidget {
  SourceTabWidget({super.key, required this.sourceList, this.selectedSource});

  final List<Source>? sourceList;
  final Source? selectedSource;

  @override
  State<SourceTabWidget> createState() => _SourceTabWidgetState();
}

class _SourceTabWidgetState extends State<SourceTabWidget>
    with SingleTickerProviderStateMixin {
  late sourceViewModel sourceviewmodel;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    sourceviewmodel = sourceViewModel(sourceRepository: injectSourceRepos());

    int initialIndex = 0;
    if (widget.sourceList != null && widget.sourceList!.isNotEmpty) {
      if (widget.selectedSource != null) {
        initialIndex = widget.sourceList!.indexOf(widget.selectedSource!);
        if (initialIndex == -1) {
          initialIndex = 0; // Fallback in case selected source is not found
        }
      }
    }

    _tabController = TabController(
      length: widget.sourceList?.length ?? 0,
      vsync: this,
      initialIndex: initialIndex,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging && widget.sourceList != null) {
        sourceviewmodel.changeIndex(_tabController.index, widget.sourceList!);
      }
    });
  }

  @override
  void didUpdateWidget(covariant SourceTabWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedSource != oldWidget.selectedSource &&
        widget.selectedSource != null) {
      int newIndex = widget.sourceList!
          .indexWhere((source) => source.id == widget.selectedSource!.id);
      if (newIndex != -1 && _tabController.index != newIndex) {
        _tabController.animateTo(newIndex);
      }
      sourceviewmodel.changeIndex(newIndex, widget.sourceList!);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sourceviewmodel,
      child: BlocBuilder<sourceViewModel, SourceStates>(
          builder: (context, state) {
        return Column(
          children: [
            DefaultTabController(
              length: widget.sourceList!.length,
              child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  indicatorColor: Theme.of(context).indicatorColor,
                  tabs: widget.sourceList!.map((source) {
                    return Text(source.name ?? "",
                        style: sourceviewmodel.seletedIndex ==
                                widget.sourceList!.indexOf(source)
                            ? AppStyle.bold16White.copyWith(
                                color: Theme.of(context).indicatorColor)
                            : AppStyle.Medium14White.copyWith(
                                color: Theme.of(context).indicatorColor));
                  }).toList()),
            ),
            Expanded(
                child: NewsWidget(
                    source: widget.sourceList![sourceviewmodel.seletedIndex]))
          ],
        );
      }

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
