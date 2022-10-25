import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final socket = await Socket.connect('0.0.0.0', 5000);
  print(
      'Client:✅ connected to: ${socket.remoteAddress.address} : ${socket.remotePort} ✅');

  socket.listen(
    (Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      print('Client:✅ $serverResponse');
    },
    onDone: () {
      print('Client:🛑 server left. 🛑');
      socket.destroy();
    },
    onError: (error) {
      print('🛑 Client $error 🛑');
      socket.destroy();
    },
  );

  String? username;
  do {
    print('enter a client username😂😂');
    username = stdin.readLineSync();
  } while (username == null || username.isEmpty);
  socket.write(username);
}
