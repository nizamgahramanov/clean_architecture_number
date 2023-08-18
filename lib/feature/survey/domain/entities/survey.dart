import 'package:equatable/equatable.dart';

class Survey extends Equatable {
  final String title;
  final String url;

  Survey({
    required this.title,
    required this.url,
  });

  @override
  List<Object?> get props => [title, url];
}
