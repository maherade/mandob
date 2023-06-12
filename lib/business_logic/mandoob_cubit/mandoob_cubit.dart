
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandob/business_logic/mandoob_cubit/mandoob_states.dart';

class MandoobCubit extends Cubit<MandoobStates>{

  MandoobCubit():super(InitialState());

  static MandoobCubit get(context)=>BlocProvider.of(context);



}