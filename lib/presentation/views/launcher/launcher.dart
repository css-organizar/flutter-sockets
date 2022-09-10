import 'package:appclient/presentation/views/client/client_page.dart';
import 'package:appclient/presentation/views/server/server_page.dart';
import 'package:flutter/material.dart';
import 'package:r_get_ip/r_get_ip.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  TextEditingController ipServidor =
      TextEditingController(text: '0.0.0.0:4040');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    ipServidor.dispose();
    super.dispose();
  }

  Widget _buildIpWidget(BuildContext context, AsyncSnapshot<String?> snapshot) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ipServidor.text =
              '${snapshot.hasData ? snapshot.data : "0.0.0.0"}:4040';
        });
      },
      child: Text(
        '${snapshot.hasData ? snapshot.data : "0.0.0.0"}',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIpWidget2(
      BuildContext context, AsyncSnapshot<String?> snapshot) {
    return Text(
      '${snapshot.hasData ? snapshot.data : "0.0.0.0"}',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Exemplo em Flutter'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text('Ip do Servidor'),
                        TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24,
                          ),
                          decoration: InputDecoration(),
                          controller: ipServidor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ServerPage(
                                ipServidor: ipServidor.text,
                              );
                            },
                          ),
                        );
                      },
                      child: Text('Servidor'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ClientPage(
                                ipServidor: ipServidor.text,
                              );
                            },
                          ),
                        );
                      },
                      child: Text('Cliente'),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blue,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Text('External IP Address'),
                FutureBuilder(
                  builder: _buildIpWidget,
                  future: RGetIp.externalIP,
                ),
                SizedBox(
                  height: 5,
                ),
                Text('internal IP Address'),
                FutureBuilder(
                  builder: _buildIpWidget,
                  future: RGetIp.internalIP,
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Network Type'),
                FutureBuilder(
                  builder: _buildIpWidget2,
                  future: RGetIp.networkType,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
