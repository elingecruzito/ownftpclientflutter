import 'package:flutter/material.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/provider/provider.dart';
import 'package:ownftpclient/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<FtpServers> _dataServers = [];

  @override
  Widget build(BuildContext context) {

    final registerProvider = Provider.registerProvider(context);
    registerProvider.loadServers();
    _dataServers = registerProvider.servers;

    return Scaffold(
      appBar: appBarCustom('Servers'),
      body: GridView.count(
        crossAxisCount: 1, 
        childAspectRatio: (1 / 0.3),
        children: List.generate(_dataServers.length, (index) => _item(context, _dataServers[index])),
      ),
      floatingActionButton: _addServer(),
    );
  }

  Widget _addServer() {

    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.lightBlue,
      onPressed: () async{
        final res = await Navigator.pushNamed(context, 'register');
        if(res){
          print(res.toString());
          setState(() {});
        }
        
      }
    );
  }

  Widget _item(BuildContext context, FtpServers dataServer) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 10.0,
      child: Stack(
        children: [
          Container(
            child: Positioned(
              top: 5.0,
              right: 10.0,
              child: InkWell(
                onTap: () => _deleteServer(dataServer.g01Id),
                child: Icon(Icons.delete_outline)
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Image(
                    image: AssetImage('assets/logo-server.png'),
                    width: 100.0,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () => print(dataServer.toJson().toString()),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 35.0, 0.0, 0.0),
                    child: Column(
                      children: [
                        Text(dataServer.g01Name),
                        SizedBox(height: 10.0),
                        Text(dataServer.g01Ip + dataServer.g01InitialDirectory)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _deleteServer(int serverId) {
    final registerProvider = Provider.registerProvider(context);
    registerProvider.deleteServer(serverId).then(( deleted ){
      if(deleted){
        setState(() {});
      }
    });
    
  }
}