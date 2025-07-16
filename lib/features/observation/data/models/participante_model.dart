import '../../domain/entities/participante.dart';

class ParticipanteModel extends Participante {
  ParticipanteModel({
    required super.participanteId,
    required super.nombre,
    required super.email,
    required super.fechaInscripcion,
  });

  factory ParticipanteModel.fromJson(Map<String, dynamic> json) {
    return ParticipanteModel(
      participanteId: json['participante_id'],
      nombre: json['nombre'],
      email: json['email'],
      fechaInscripcion: DateTime.parse(json['fecha_inscripcion']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'participante_id': participanteId,
      'nombre': nombre,
      'email': email,
      'fecha_inscripcion': fechaInscripcion.toIso8601String(),
    };
  }
} 