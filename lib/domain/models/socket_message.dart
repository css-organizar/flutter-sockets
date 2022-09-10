// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum SocketMessageType {
  connected,
  disconnected,
  message,
  info,
}

class SocketMessage {
  int? code;
  String? message;
  SocketMessageData? data;
  SocketMessage({
    this.code,
    this.message,
    this.data,
  });

  SocketMessage copyWith({
    int? code,
    String? message,
    SocketMessageData? data,
  }) {
    return SocketMessage(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory SocketMessage.fromMap(Map<String, dynamic> map) {
    return SocketMessage(
      code: map['code'] != null ? map['code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? SocketMessageData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketMessage.fromJson(String source) =>
      SocketMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SocketMessage(code: $code, message: $message, data: $data)';

  @override
  bool operator ==(covariant SocketMessage other) {
    if (identical(this, other)) return true;

    return other.code == code && other.message == message && other.data == data;
  }

  @override
  int get hashCode => code.hashCode ^ message.hashCode ^ data.hashCode;
}

class SocketMessageData {
  int? segundos;
  int? competidor1F;
  int? competidor1P;
  int? competidor2F;
  int? competidor2P;

  SocketMessageData({
    this.segundos,
    this.competidor1F,
    this.competidor1P,
    this.competidor2F,
    this.competidor2P,
  });

  SocketMessageData copyWith({
    int? segundos,
    int? competidor1F,
    int? competidor1P,
    int? competidor2F,
    int? competidor2P,
  }) {
    return SocketMessageData(
      segundos: segundos ?? this.segundos,
      competidor1F: competidor1F ?? this.competidor1F,
      competidor1P: competidor1P ?? this.competidor1P,
      competidor2F: competidor2F ?? this.competidor2F,
      competidor2P: competidor2P ?? this.competidor2P,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'segundos': segundos,
      'competidor1F': competidor1F,
      'competidor1P': competidor1P,
      'competidor2F': competidor2F,
      'competidor2P': competidor2P,
    };
  }

  factory SocketMessageData.fromMap(Map<String, dynamic> map) {
    return SocketMessageData(
      segundos: map['segundos'] != null ? map['segundos'] as int : null,
      competidor1F:
          map['competidor1F'] != null ? map['competidor1F'] as int : null,
      competidor1P:
          map['competidor1P'] != null ? map['competidor1P'] as int : null,
      competidor2F:
          map['competidor2F'] != null ? map['competidor2F'] as int : null,
      competidor2P:
          map['competidor2P'] != null ? map['competidor2P'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SocketMessageData.fromJson(String source) =>
      SocketMessageData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SocketMessageData(segundos: $segundos, competidor1F: $competidor1F, competidor1P: $competidor1P, competidor2F: $competidor2F, competidor2P: $competidor2P)';
  }

  @override
  bool operator ==(covariant SocketMessageData other) {
    if (identical(this, other)) return true;

    return other.segundos == segundos &&
        other.competidor1F == competidor1F &&
        other.competidor1P == competidor1P &&
        other.competidor2F == competidor2F &&
        other.competidor2P == competidor2P;
  }

  @override
  int get hashCode {
    return segundos.hashCode ^
        competidor1F.hashCode ^
        competidor1P.hashCode ^
        competidor2F.hashCode ^
        competidor2P.hashCode;
  }
}
