import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/utils/app_style.dart';

class categoryDetails extends StatelessWidget {
  static const categoryDetailsId = "CategoryDetails";
  const categoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text('An error occured'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          }

          //server return response(success,error)

          if (snapshot.data!.status == 'error') {
            return Center(
              child: Column(
                children: [
                  Text(snapshot.data!.message!),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          } else {
            var sourceList = snapshot.data!.sources;

            return SourceTabWidget(sourceList: sourceList);
          }
        });
  }
}

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
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                style: selectedIndex == widget.sourceList!.indexOf(source)
                    ? AppStyle.bold16White
                        .copyWith(color: Theme.of(context).indicatorColor)
                    : AppStyle.Medium14White.copyWith(
                        color: Theme.of(context).indicatorColor));
          }).toList()),
    );
  }
}
