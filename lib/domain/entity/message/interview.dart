dynamic data = {
  "interview": {
    "id": 157,
    "createdAt": "2024-05-02T07:20:41.403Z",
    "updatedAt": "2024-05-02T07:20:41.403Z",
    "deletedAt": null,
    "title": "Meeting 2",
    "startTime": "2024-04-27T01:36:15.102Z",
    "endTime": "2024-04-27T01:36:15.102Z",
    "disableFlag": 0,
    "meetingRoomId": 175,
    "meetingRoom": {
      "id": 175,
      "createdAt": "2024-05-02T07:20:41.398Z",
      "updatedAt": "2024-05-02T07:20:41.398Z",
      "deletedAt": null,
      "meeting_room_code": "abcde",
      "meeting_room_id": "abcdf",
      "expired_at": null
    }
  }
};

class MeetingRoom {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String meetingRoomCode;
  final String meetingRoomId;
  final dynamic expiredAt;
  MeetingRoom({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.meetingRoomCode,
    required this.meetingRoomId,
    this.expiredAt,
  });

  factory MeetingRoom.fromJson(Map<String, dynamic> map) {
    return MeetingRoom(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt: map['deletedAt'],
      meetingRoomCode: map['meeting_room_code'],
      meetingRoomId: map['meeting_room_id'],
      expiredAt: map['expired_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt,
      'meeting_room_code': meetingRoomCode,
      'meeting_room_id': meetingRoomId,
      'expired_at': expiredAt,
    };
  }
}

class Interview {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final int disableFlag;
  final int meetingRoomId;
  final MeetingRoom meetingRoom;
  Interview({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.disableFlag,
    required this.meetingRoomId,
    required this.meetingRoom,
  });

  factory Interview.fromJson(Map<String, dynamic> map) {
    return Interview(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt: map['deletedAt'],
      title: map['title'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      disableFlag: map['disableFlag'],
      meetingRoomId: map['meetingRoomId'],
      meetingRoom: MeetingRoom.fromJson(map['meetingRoom']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt,
      'title': title,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'disableFlag': disableFlag,
      'meetingRoomId': meetingRoomId,
      'meetingRoom': meetingRoom.toJson(),
    };
  }
}
