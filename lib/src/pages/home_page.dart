import 'package:flutter/material.dart';
import 'package:ownftpclient/src/models/ftp_servers_model.dart';
import 'package:ownftpclient/src/pages/register_page.dart';
import 'package:ownftpclient/src/provider/provider.dart';
import 'package:ownftpclient/src/provider/register_provider.dart';
import 'package:ownftpclient/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<FtpServers> _dataServers = [];
  RegisterProvider registerProvider;

  @override
  Widget build(BuildContext context) {

    registerProvider = Provider.registerProvider(context);
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
        final res = await Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => RegisterPage()
          )
        );
        if( res ){
          await registerProvider.loadServers();
          setState(() {
            _dataServers = registerProvider.servers;
          });
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
                onTap: () => _deleteServer(dataServer),
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
                  onTap: () => Navigator.pushNamed(context, 'files', arguments: dataServer), // init server page
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

  _deleteServer(FtpServers dataServer) {

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm...'),
          content: Text('Do you want to delete ${dataServer.g01Name} server?'),
          actions: [
            TextButton( 
              child: Text('Ok'),
              onPressed: () {
                registerProvider.deleteServer(dataServer.g01Id).then(( deleted ) async{
                  if( deleted ){
                    Navigator.of(context).pop();
                    await registerProvider.loadServers();
                    setState(() {
                      _dataServers = registerProvider.servers;
                    });
                  }
                });
              }
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        );
      }
    );
    
  }
}