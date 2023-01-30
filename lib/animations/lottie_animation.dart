enum LottieAnimation {
  dataNotFound(name: 'data_not_found'),
  empty(name: 'empty'),
  loading(name: 'loading'),
  error(name: 'error'),
  smallError(name: 'small_error'),
  connection(name:'connection'),
  active(name:'active');

  final String name;
  const LottieAnimation({
    required this.name,
  });
}
