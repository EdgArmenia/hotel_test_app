import 'package:flutter/material.dart';
import 'package:hotel_test_app/common/constants.dart';
import 'package:hotel_test_app/common/widgets/action_button_widget.dart';
import 'package:hotel_test_app/common/widgets/body_field_widget.dart';
import 'package:hotel_test_app/common/widgets/image_widget.dart';
import 'package:hotel_test_app/common/widgets/price_widget.dart';
import 'package:hotel_test_app/common/widgets/tag_list_widget.dart';
import 'package:hotel_test_app/common/widgets/title_widget.dart';
import 'package:hotel_test_app/core/utils/utils.dart';

import '../../../../common/widgets/tag_widget.dart';
import '../../../domain/entities/room_entity.dart';

class RoomCardWidget extends StatelessWidget {
  const RoomCardWidget({
    super.key,
    required RoomEntity room,
    required void Function() navigateToReservation,
  })  : _navigateToReservation = navigateToReservation,
        _room = room;

  final RoomEntity _room;
  final void Function() _navigateToReservation;

  @override
  Widget build(BuildContext context) {
    return BodyFieldWidget(
      imageWidget: ImageWidget(
          images: _room.imageUrls,
        ),
      children: [
        titleWidget(context, title: _room.name),
        const SizedBox(height: 8.0),
        tagListWidget(
          dataList: _room.peculiarities,
          color: Colors.grey.shade600,
        ),
        const SizedBox(height: 8.0),
        const TagWidget(
          title: Constants.ABOUT_ROOM,
          color: Colors.blue,
        ),
        const SizedBox(height: 16.0),
        priceWidget(
          context,
          minimalPrice: Utils.convertToPriceFormat(_room.price),
          priceForIt: _room.pricePer,
        ),
        const SizedBox(height: 16.0),
        ActionButtonWidget(
          title: Constants.NAVIGATE_TO_RESERVATION_TITLE,
          action: _navigateToReservation,
        ),
      ],
    );
  }
}
