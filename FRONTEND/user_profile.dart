import 'dart:convert';
import 'dart:typed_data';

class TravelMemory {
  const TravelMemory({
    required this.id,
    required this.placeName,
    required this.location,
    required this.visitedAt,
    required this.photoBase64,
    required this.note,
    required this.story,
    required this.audioUrl,
    required this.confidence,
  });

  final String id;
  final String placeName;
  final String location;
  final DateTime visitedAt;
  final String photoBase64;
  final String note;
  final String story;
  final String audioUrl;
  final int confidence;

  Uint8List? get photoBytes {
    if (photoBase64.isEmpty) return null;
    try {
      return base64Decode(photoBase64);
    } on FormatException {
      return null;
    }
  }

  factory TravelMemory.fromMap(Map<String, dynamic> map) {
    return TravelMemory(
      id: map['id']?.toString() ?? '',
      placeName: map['placeName']?.toString() ?? 'Travel memory',
      location: map['location']?.toString() ?? '',
      visitedAt:
          DateTime.tryParse(map['visitedAt']?.toString() ?? '') ??
          DateTime.now(),
      photoBase64: map['photoBase64']?.toString() ?? '',
      note: map['note']?.toString() ?? '',
      story: map['story']?.toString() ?? '',
      audioUrl: map['audioUrl']?.toString() ?? '',
      confidence: int.tryParse(map['confidence']?.toString() ?? '') ?? 0,
    );
  }
}
