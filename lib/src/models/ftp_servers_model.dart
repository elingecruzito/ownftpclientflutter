// To parse this JSON data, do
//
//     final ftpServers = ftpServersFromJson(jsonString);

import 'dart:convert';

FtpServers ftpServersFromJson(String str) => FtpServers.fromJson(json.decode(str));

String ftpServersToJson(FtpServers data) => json.encode(data.toJson());

class FtpServers {
    FtpServers({
        this.g01Id,
        this.g01Name,
        this.g01Ip,
        this.g01InitialDirectory,
        this.g01User,
        this.g01Password,
    });

    int g01Id;
    String g01Name;
    String g01Ip;
    String g01InitialDirectory;
    String g01User;
    String g01Password;

    factory FtpServers.fromJson(Map<String, dynamic> json) => FtpServers(
        g01Id: json["g01_id"],
        g01Name: json["g01_name"],
        g01Ip: json["g01_ip"],
        g01InitialDirectory: json["g01_initial_directory"],
        g01User: json["g01_user"],
        g01Password: json["g01_password"],
    );

    Map<String, dynamic> toJson() => {
        "g01_id": g01Id,
        "g01_name": g01Name,
        "g01_ip": g01Ip,
        "g01_initial_directory": g01InitialDirectory,
        "g01_user": g01User,
        "g01_password": g01Password,
    };
}
