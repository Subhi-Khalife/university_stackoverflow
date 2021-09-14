part of 'common_question_bloc.dart';

enum CommonQuestionStatus {
  inital,
  success,
  error,
  loading,
}

class CommonQuestionState {
  final List<CommonQuestion> commonItemsList;
  final CommonQuestionStatus status;
  final bool hasReachedMax;
  CommonQuestionState({
    this.commonItemsList = const <CommonQuestion>[],
    this.status = CommonQuestionStatus.inital,
    this.hasReachedMax = false,
  });

  CommonQuestionState copyWith({
    List<CommonQuestion> commonItemsList,
    CommonQuestionStatus status,
    bool hasReachedMax,
  }) {
    return CommonQuestionState(
        commonItemsList: commonItemsList ?? this.commonItemsList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        status: status ?? this.status);
  }
}
