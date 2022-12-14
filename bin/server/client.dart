import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final socket = await Socket.connect('0.0.0.0', 5000);
  print(
      'Client:β connected to: ${socket.remoteAddress.address} : ${socket.remotePort} β');

  socket.listen(
    (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print('Client:β $serverResponse');
    },
    onDone: () {
      print('Client:π server left. π');
      socket.destroy();
    },
    onError: (error) {
      print('π Client $error π');
      socket.destroy();
    },
  );

  String? username;
  do {
    print('enter a client usernameππ');
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);
  socket.write(username);
}
