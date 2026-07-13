import 'package:flutter/material.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String> agentTrace;
  final TripResultPayload? tripResult;

  ChatMessage({
    required this.text,
    required this.isUser,
    DateTime? timestamp,
    List<String>? agentTrace,
    this.tripResult,
  }) : timestamp = timestamp ?? DateTime.now(),
       agentTrace = List.unmodifiable(agentTrace ?? const []);
}

class TripResultPayload {
  final String title;
  final String subtitle;
  final List<TripResultSection> sections;

  const TripResultPayload({
    required this.title,
    required this.subtitle,
    required this.sections,
  });
}

class TripResultSection {
  final String title;
  final IconData icon;
  final List<TripResultOption> options;

  const TripResultSection({
    required this.title,
    required this.icon,
    required this.options,
  });
}

class TripResultOption {
  final String title;
  final String subtitle;
  final String badge;
  final List<TripResultDetail> details;
  final String? actionUrl;
  final String? actionLabel;

  const TripResultOption({
    required this.title,
    required this.subtitle,
    required this.badge,
    required this.details,
    this.actionUrl,
    this.actionLabel,
  });
}

class TripResultDetail {
  final String label;
  final String value;

  const TripResultDetail({required this.label, required this.value});
}

class Destination {
  final String name;
  final String country;
  final String emoji;
  final String tag;
  final List<Color> gradient;

  const Destination({
    required this.name,
    required this.country,
    required this.emoji,
    required this.tag,
    required this.gradient,
  });
}
