import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IntencionesScreen extends StatelessWidget {
  const IntencionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Intenciones'),),
      body: GridView(
        padding: EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8
          ),
        children: [
          intentCard(icon: Icons.web_stories, title: 'https://celaya.tecnm.mx', sizeLetter: 18, actionFunction: openWeb),
          intentCard(title: 'tel:4613540049', icon: Icons.phone, sizeLetter: 20, actionFunction: callPhone),
          intentCard(title: 'sms:4613540049',icon: Icons.sms, sizeLetter: 20, actionFunction: sendSms),
          intentCard(title: 'Email: 20030974@itcelaya.edu.mx',icon: Icons.email, sizeLetter: 15, actionFunction: sendEmail)
          ],
      )
    );
  }

  openWeb() async {
    Uri uri = Uri.parse('https://celaya.tecnm.mx');
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  callPhone() async {
    Uri uri = Uri.parse('tel:4613540049');
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  sendSms() async {
    Uri uri = Uri.parse('sms:4613540049');
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  sendEmail() async {
    Uri uri = Uri(
      scheme: 'mailto',
      path: '20030974@itcelaya.edu.mx',
      query: 'subject= Hola mundo :)&body= Van a aprobar'
    );
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  Widget intentCard({required String title, required IconData icon,required double sizeLetter, Function()? actionFunction}){
    return GestureDetector(
      onTap: actionFunction,
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueAccent[100]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80,),
            Text(title, style:  TextStyle(fontSize: sizeLetter,))
          ],
        ),
      ),
    );
  }
}