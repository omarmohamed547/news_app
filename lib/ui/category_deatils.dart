import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/ui/source_tab.dart';
import 'package:news_route/utils/app_style.dart';

class categoryDetails extends StatelessWidget {
  CategoryModel categoryModel;
  categoryDetails({required this.categoryModel, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SourceResponse?>(
        future: ApiManager.getSources(categoryModel.id),
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
