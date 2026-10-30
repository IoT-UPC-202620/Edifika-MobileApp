import 'package:flutter/material.dart';

import '../../../core/widgets/status_chip.dart';
import '../domain/reservation_block.dart';

/// Texto + tono del estado de una reserva, tal como lo muestra Figma.
(String, StatusTone) reservationStatus(ReservationBlock block, DateTime now) {
  return switch (block.status) {
    'ACTIVE' when block.isUpcoming(now) => ('Confirmada', StatusTone.success),
    'ACTIVE' => ('Realizada', StatusTone.neutral),
    'CANCELLED' => ('Cancelada', StatusTone.neutral),
    'REJECTED' => ('Rechazada', StatusTone.danger),
    _ => (block.status, StatusTone.neutral),
  };
}

/// Ícono por tipo de área común (tipos de `CommonAreaType` del web).
IconData areaIcon(String type) => switch (type.toUpperCase()) {
      'POOL' => Icons.pool_outlined,
      'GYM' => Icons.fitness_center_outlined,
      'BBQ_AREA' => Icons.outdoor_grill_outlined,
      'PARTY_ROOM' || 'MULTIPURPOSE_ROOM' => Icons.celebration_outlined,
      'MEETING_ROOM' || 'COWORKING_ROOM' => Icons.groups_outlined,
      'SPORTS_COURT' => Icons.sports_soccer_outlined,
      'PLAYGROUND' => Icons.toys_outlined,
      'TERRACE' || 'LOUNGE' => Icons.deck_outlined,
      'GARDEN' || 'PET_AREA' => Icons.park_outlined,
      'LAUNDRY_ROOM' => Icons.local_laundry_service_outlined,
      'PARKING_AREA' => Icons.local_parking_outlined,
      _ => Icons.meeting_room_outlined,
    };
