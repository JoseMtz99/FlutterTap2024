
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:regexed_validator/regexed_validator.dart';
main() {
  print( validator.email('example@example.co.uk') ); 

  print(validator.url('http://www.nowhere.com?product=28&color=blue')); 
}

final _fromKey = GlobalKey<FormState>();
final TextEditingController _controller =  TextEditingController();


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late XFile foto;

  bool pwCorrect = false, emailCorrect= false, urlCorrect=false, telCorrect=false, imageTrue=false;
  
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    
    var email=false.obs;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        
      appBar: AppBar(
        title: const Text('Registro nuevo'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Positioned(
              child: imageTrue 
                  ? Image.file(File(foto.path))
                  : Container()
            ),
            Column(
              children: [
                Positioned(
                  top: 30,
                  left: 10,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.edit),
                    onPressed: (){
                      pickImage();
                    }, 
                    label: const Text('Seleccionar una imagen'),
                    )
                  ),
                  Positioned(
              top: 100,
                left: 10,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  onPressed: (){
                    captureImage();
                  }, 
                  label: const Text('Capturar desde la camara'),
                  )
              ),
              ],
            ),
            
            Form(
              key: _fromKey,
                child:SizedBox(
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      TextFormField(
                        validator: (name) => name!.length < 4 ? 'El nombre debe contener al menos 4 letras':null,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          label: Text('Nombre', style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),)
                        ),
                      ),
                      Obx(()=>TextFormField(
                        validator: (value){
                          if(!emailCorrect){
                            return 'Ingresa un email válido';
                          }
                        },
                        onChanged: (asd){
                          if (EmailValidator.validate(asd)) {
                            emailCorrect=true;
                            email(true);
                          }else{
                            
                            emailCorrect= false;
                            email(false);
                          }
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2),
                          borderSide: BorderSide(width:2, color:email.value? Colors.green: Colors.blue),
                          
                            ),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 2, color:email.value? Colors.green: Colors.red)
                            ),
                            suffixIcon: email.value?  const Icon(Icons.done):const Icon(Icons.cancel),
                            //suffixIcon: Icon(Icons.done, color: email.value? Colors.green: Colors.blue,),
                          label:const Text('Email', style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),)
                        ),
                      )),
                      TextFormField(
                        validator: (password){
                          if (!pwCorrect) {
                            return 'Ingresa una contraseña válida';
                          }
                        },
                        obscureText: showPassword,
                        controller: _controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                showPassword=!showPassword;
                                
                              });
                            }, 
                            icon:const Icon(Icons.visibility_off)),
                          label:const Text('Contraseña', style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),)
                        ),
                      ),
                      const SizedBox(width: 50,),
                      FlutterPwValidator(
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        width: 400, 
                        height: 150, 
                        minLength: 6, 
                        onSuccess: (){
                          pwCorrect=true;
                        }, 
                        onFail: (){
                          pwCorrect=false;
                        },
                        controller: _controller),
                      TextFormField(
                        validator: (url) {
                          if (!validator.url(url!)) {
                            urlCorrect=false;
                            return 'Ingresa una dirección válida';
                          }else urlCorrect= true;
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text('Pagina de GitHub', style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),)
                        ),
                      ),
                      TextFormField(
                        validator: (telefono) {
                          if (telefono?.length==10) {
                            telCorrect=true;
                          }else {
                            telCorrect=false;
                            return 'Ingresa un teléfono válido';
                          }
                        } ,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                        ],
                        decoration: const InputDecoration(
                          label: Text('Teléfono', style:TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),)
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_fromKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Registrar usuario')
                      ),
                    ]           
                  ),
                ),
                
              ),
            ],
          ),
      ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
      if (image!=null) {
        foto = image;
        imageTrue = true;
        setState(() { });
        !imageTrue; 
      }
    
  }
  
  void captureImage() async {
    
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image!=null) {
        foto = image;
        imageTrue = true;
        setState(() {});
        !imageTrue;
      }
    
  }
  
  
  
  
}