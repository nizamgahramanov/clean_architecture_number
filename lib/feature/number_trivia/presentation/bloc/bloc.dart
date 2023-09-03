import 'package:clean_architecture_number/core/error/failures.dart';
import 'package:clean_architecture_number/core/usecases/usecase.dart';
import 'package:clean_architecture_number/core/util/input_converter.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_number/feature/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_trivia_bloc.dart';
part 'number_trivia_event.dart';
part 'number_trivia_state.dart';
