import 'dart:io';
import 'dart:typed_data';

Future<void> main() async {
  final ipAddress = InternetAddress.anyIPv4;
  final serverSocket = await ServerSocket.bind(ipAddress, 5000);

  print('✅ server is running on ${ipAddress.address}:5000✅ ✅.....🔥🔥🔥');

  serverSocket.listen((Socket event) {
    handleConnection(event);
  });
}

List<Socket> clients = [];

void handleConnection(Socket client) {
  print(
      'Server: ✅ connection from ${client.remoteAddress.address}:${client.remotePort} ✅');
  client.listen(
    (Uint8List data) {
      final message = String.fromCharCodes(data);

      for (var c in clients) {
        c.write('Server: ✅ $message joined the connection');
      }

      clients.add(client);

      client.write('Server:✅ you are now logged in as $message');
    },
    onDone: () {
      print('Server:🛑 client left 🛑');
      client.close();
    },
    onError: (error) {
      print('🛑 error 🛑 $error');
      client.close();
    },
  );
}
