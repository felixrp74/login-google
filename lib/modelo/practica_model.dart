// To parse this JSON data, do
//
//     final practicaModel = practicaModelFromJson(jsonString);

import 'dart:convert';

PracticaModel practicaModelFromJson(String str) => PracticaModel.fromJson(json.decode(str));

String practicaModelToJson(PracticaModel data) => json.encode(data.toJson());

class PracticaModel {
    PracticaModel({
        this.name,
        this.profesion,
        this.sueldo,
        this.habilidades,
    });

    String name;
    String profesion;
    String sueldo;
    List<String> habilidades;

    factory PracticaModel.fromJson(Map<String, dynamic> json) => PracticaModel(
        name: json["name"],
        profesion: json["profesion"],
        sueldo: json["sueldo"],
        habilidades: List<String>.from(json["habilidades"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "profesion": profesion,
        "sueldo": sueldo,
        "habilidades": List<dynamic>.from(habilidades.map((x) => x)),
    };
}





// diseno de tabla practicas
// {
//   "name"       : "se busca ingeniero",
//   "profesion"  : "ingeniero software",
//   "sueldo"     : 234,
//   "habilidades": ["programar", "BD"],
// }