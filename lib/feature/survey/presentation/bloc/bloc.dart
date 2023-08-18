import 'package:clean_architecture_number/core/usecases/usecase.dart';
import 'package:clean_architecture_number/feature/survey/domain/usercases/get_survey.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/survey.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'survey_bloc.dart';
part 'survey_event.dart';
part 'survey_state.dart';