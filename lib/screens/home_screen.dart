import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:tap2024/main.dart';
import 'package:tap2024/settings/value_listener.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tópicos avanzados'),),
      drawer: menuLateral(context),
    );
  }

  Widget menuLateral(BuildContext context){
    return  Drawer(
      child: Container(
        decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/raptor.jpg'),
                  ) 
              ),
        child: ListView(
          children: [
             const UserAccountsDrawerHeader(  
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://th.bing.com/th/id/R.714e059760d4fc75665e2fca39eb9833?rik=%2bg0uoah0pbFy0g&riu=http%3a%2f%2fwww.omnia.com.mx%2fpublic%2fcargas%2fnoticias%2f2019%2fmar%2f05%2fobj100262%2fbig_22euspr8.jpg&ehk=OFWkE7iQWXC%2bpG6Mneb%2bk4UHiIntKGEQilUHDevzA7s%3d&risl=&pid=ImgRaw&r=0'),
              ),
              accountName: Text('Jose Martinez'), 
              accountEmail: Text('20030974@itcelaya.edu.mx')
              ),
              ListTile(
                tileColor: Colors.greenAccent,
                title:  Text('Login'),
                subtitle: Text('Direccion de youtube'),
                leading: Icon(Icons.key),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, "/login2"),
              ),
              ListTile(
                tileColor: Colors.greenAccent,
                title:  Text('Intenciones'),
                subtitle: Text('Acciones implícitas'),
                leading: Icon(Icons.abc),
                trailing: Icon(Icons.chevron_right),
                onTap: () => Navigator.pushNamed(context, "/intent"),
              ),
              DayNightSwitcher(
                isDarkModeEnabled: ValueListener.isdark.value, 
                onStateChanged: (isDarkModeEnabled) {
                  ValueListener.isdark.value=isDarkModeEnabled;
                },)
          ],
        ),
      ),
    );
  }
}