import 'package:flutter/material.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/ui/category_details/category_details_viewmodel.dart';
import 'package:news_route/ui/source_tab.dart';
import 'package:news_route/utils/app_style.dart';
import 'package:provider/provider.dart';

class categoryDetails extends StatefulWidget {
  CategoryModel categoryModel;
  categoryDetails({required this.categoryModel, super.key});

  @override
  State<categoryDetails> createState() => _categoryDetailsState();
}

class _categoryDetailsState extends State<categoryDetails> {
  CategoryDetailsViewmodel categoryDetailsViewmodel =
      CategoryDetailsViewmodel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoryDetailsViewmodel.getSource(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => categoryDetailsViewmodel,
        child: Consumer<CategoryDetailsViewmodel>(
            builder: (context, categoryDetailsViewmodel, child) {
          if (categoryDetailsViewmodel.errorMessage != null) {
            return Center(
              child: Column(
                children: [
                  Text(categoryDetailsViewmodel.errorMessage!),
                  ElevatedButton(
                    onPressed: () {
                      categoryDetailsViewmodel
                          .getSource(widget.categoryModel.id);
                    },
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          } else if (categoryDetailsViewmodel.sourceList == null) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          } else {
            return SourceTabWidget(
                sourceList: categoryDetailsViewmodel.sourceList);
          }
        })

        /* FutureBuilder<SourceResponse?>(
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
          }),*/
        );
  }
}
