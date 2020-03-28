class ClientNames {
  final String nameOfClient;

  ClientNames({this.nameOfClient});

  factory ClientNames.fromJson(Map<String, dynamic> json) {
    return ClientNames(
      nameOfClient: json['clientNamesAPI'],
    );
  }
}