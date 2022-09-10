import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';

class Server {
  Server(
    this.hostname,
    this.onData,
    this.onError,
    this.callback,
  );

  final String hostname;
  final Function(Uint8List data) onData;
  final Function(dynamic data) onError;
  final ValueChanged<String> callback;

  bool running = false;
  List<Socket> sockets = [];

  ServerSocket? server;

  start() async {
    runZonedGuarded(
      () async {
        var enderecoServidor = hostname.split(':');
        server = await ServerSocket.bind(
            enderecoServidor[0], int.parse(enderecoServidor[1]));
        running = true;
        server!.listen(onRequest, onDone: disconnect);
        onData(Uint8List.fromList('Server listening on port 4040'.codeUnits));
      },
      (error, stackTrace) {
        onError(error.toString());
      },
    );
  }

  stop() async {
    await server?.close();
    server = null;
    running = false;
  }

  broadCast(String message) {
    onData(Uint8List.fromList('Broadcasting : $message'.codeUnits));
    for (Socket socket in sockets) {
      socket.write('$message\n');
    }
  }

  onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((Uint8List data) {
      onData(data);
      callback(String.fromCharCodes(data));
    });
  }

  disconnect() {}
}
