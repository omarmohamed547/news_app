import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_route/apis/api_manager.dart';
import 'package:news_route/models/source_response/source.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource.dart';
import 'package:news_route/repository/source/dataSource/source_remote_dataSource_impl.dart';
import 'package:news_route/repository/source/repository/source_repos.dart';
import 'package:news_route/repository/source/repository/source_reps_impl.dart';
import 'package:news_route/ui/category_details/cubit/source_states.dart';

class sourceViewModel extends Cubit<SourceStates> {
  SourceRepository sourceRepository;
// extend att , methods expect constructor
  sourceViewModel({required this.sourceRepository})
      : super(SourceLoadingState());

  ///constructor injection
//hold data
  int seletedIndex = 0;
  List<Source> sourceListt = [];
//handle logic
  void changeIndex(int index, List<Source> sourceList) {
    seletedIndex = index;
    sourceListt = sourceList;

    // Update seletedIndex correctly
    emit(SourceSucessState(sourceList: sourceList));
  }

  void getSource(String categotyId) async {
    try {
      emit(SourceLoadingState());
      var response = await sourceRepository.getSources(categotyId);
      if (response!.status == 'error') {
        emit(SourceFailureState(errorMessage: response.message!));
      } else {
        emit(SourceSucessState(sourceList: response.sources!));
        sourceListt = response.sources!;
        print(
            "Fetched Sources: ${sourceListt.map((s) => s.name).toList()}"); // Debugging
      }
    } catch (e) {
      emit(SourceFailureState(errorMessage: e.toString()));
    }
  }
}
