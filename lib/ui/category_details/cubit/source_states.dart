import 'package:news_route/models/source_response/source.dart';

abstract class SourceStates {}

class SourceLoadingState extends SourceStates {}

class SourceFailureState extends SourceStates {
  String errorMessage;
  SourceFailureState({required this.errorMessage});
}

class SourceSucessState extends SourceStates {
  List<Source> sourceList;
  SourceSucessState({required this.sourceList});
}
