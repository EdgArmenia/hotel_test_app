import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_test_app/common/icons/app_icons.dart';
import 'package:hotel_test_app/common/constants.dart';
import 'package:hotel_test_app/core/mapping/map_failure_to_message.dart';
import 'package:hotel_test_app/core/usecases/params/no_params.dart';
import 'package:hotel_test_app/core/utils/hotel_feature.dart';
import 'package:hotel_test_app/feature/domain/entities/hotel_entity.dart';
import 'package:hotel_test_app/feature/presentation/bloc/room_bloc/room_bloc.dart';

import '../../../domain/usecases/get_hotel.dart';

part 'hotel_state.dart';


class HotelCubit extends Cubit<HotelState> {
  final GetHotel _getHotel;

  HotelCubit(this._getHotel) : super(HotelLoadingState());

  void loadHotel() async {
    final failureOrHotel = await _getHotel(NoParams());

    failureOrHotel.fold(
      (failure) => emit(HotelErrorState(mapFailureToMessage(failure))),
      (hotel) => emit(HotelLoadedState(hotel)),
    );
  }


  List<HotelFeature> get features => [
        HotelFeature(
          title: Constants.COMFORT_FEATURE,
          icon: AppIcons.happyEmojiIcon,
        ),
        HotelFeature(
          title: Constants.WHAT_INCLUDED_FEATURE,
          icon: AppIcons.checkedIcon,
        ),
        HotelFeature(
          title: Constants.WHAT_NOT_INCLUDED_FEATURE,
          icon: AppIcons.closeIcon,
        ),
      ];

  void navigateToRoom(BuildContext context, String hotelName) {
    context.read<RoomBloc>().add(RoomLoadEvent());

    Navigator.pushNamed(context, Constants.ROOM_ROUTE, arguments: hotelName);
  }
}
