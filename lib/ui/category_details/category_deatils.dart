import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/category_model.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/models/source_response/source_response.dart';
import 'package:news_route/ui/category_details/cubit/source_states.dart';
import 'package:news_route/ui/category_details/cubit/source_view_model.dart';
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
  sourceViewModel sourceviewmodel = sourceViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sourceviewmodel.getSource(widget.categoryModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sourceviewmodel,
      child: BlocBuilder<sourceViewModel, SourceStates>(
        builder: (context, state) {
          if (state is SourceSucessState) {
            return SourceTabWidget(sourceList: state.sourceList);
          } else if (state is SourceFailureState) {
            return Center(
              child: Column(
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                    onPressed: () {
                      sourceviewmodel.getSource(widget.categoryModel.id);
                    },
                    child: Text('Try Again'),
                  )
                ],
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.grey,
            ));
          }
        },
      ),
    );

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
  }
}
