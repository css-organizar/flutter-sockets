import 'dart:io';
import 'dart:typed_data';
import 'package:appclient/domain/models/socket_message.dart';

class Client {
  Client(
    this.hostname,
    this.port,
    this.onData,
    this.onError,
  );

  final String hostname;
  final int port;
  final Function(Uint8List data) onData;
  final Function(dynamic data) onError;
  late bool connected = false;

  Socket? socket;

  connect() async {
    try {
      var enderecoServidor = hostname.split(':');
      socket = await Socket.connect(
          enderecoServidor[0], int.parse(enderecoServidor[1]));

      socket!.listen(
        onData,
        onError: onError,
        onDone: disconnect,
        cancelOnError: false,
      );

      connected = true;

      write(
        SocketMessage(code: 0),
      );
    } on Exception catch (exception) {
      onData(Uint8List.fromList("Error : $exception".codeUnits));
    }
  }

  write(SocketMessage message) {
    //Connect standard in to the socket
    socket!.write('${message.toJson()}\n');

    if (message.code == 0) {
      onData(Uint8List.fromList('connected\n'.codeUnits));
    }

    if (message.code == 1) {
      onData(Uint8List.fromList('disonnected\n'.codeUnits));
    }
  }

  disconnect() {
    if (socket != null) {
      write(
        SocketMessage(code: 1),
      );
      socket!.destroy();
      connected = false;
    }
  }
}
