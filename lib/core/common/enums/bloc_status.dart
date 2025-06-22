enum BlocStatus {
  notInitialized,
  inProgress,
  completed,
  incorrect,
  failed,
  connectionFailed,
  unAutorized;

  bool get isComplated => this == BlocStatus.completed;
  bool get isProgress => this == BlocStatus.inProgress;
}
