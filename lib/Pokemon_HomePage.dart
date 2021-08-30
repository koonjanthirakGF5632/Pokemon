import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janthirak_mobile_dev/Detail_Pokemon.dart';
import 'package:janthirak_mobile_dev/Model/Pokemon_model.dart';
import 'package:janthirak_mobile_dev/SignIn_page.dart';
import 'package:janthirak_mobile_dev/bloc/list_data_pokemon/list_data_pokemon_bloc.dart';
import 'dart:math' as math;

class Pokemon_HomePage extends StatefulWidget {
  @override
  _Pokemon_HomePageState createState() => _Pokemon_HomePageState();
}

class _Pokemon_HomePageState extends State<Pokemon_HomePage> {
  ListDataPokemonBloc? _DataBloc;
  Widget _widgetBox = SizedBox();
  PokemonModel? _dataModel;

  var  _image;



  Future getImageCamera() async {

    final XFile? photocamera = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _image = photocamera;
    });
  }

  Widget getImg() {
    if(_image == null){
      return Container(
        margin: EdgeInsets.only(left: 5,top: 2),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black,width: 1),
          shape: BoxShape.circle,
          image: DecorationImage(
            image: NetworkImage('https://thumbs.dreamstime.com/b/user-icon-member-login-vector-isolated-white-background-form-155134186.jpg',),
            fit: BoxFit.fill,
          ),
        ),
      );
    }
    else{
      return Container(
        margin: EdgeInsets.only(left: 5,top: 2),
          width: double.infinity,
          height: 50,
          decoration: new BoxDecoration(
              border: Border.all(color: Colors.lightGreen,width: 1),
              shape: BoxShape.circle,
              image: new DecorationImage(
                image: FileImage(File(_image.path)),
                fit: BoxFit.fill,
              )
          )
      );
    }
  }


  Widget build(BuildContext context) {

    _DataBloc = BlocProvider.of<ListDataPokemonBloc>(context);
    final auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Stack(
          children: [
            getImg(),
            GestureDetector(
              onTap: (){
                getImageCamera();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 41,top: 30),
                child: Icon(Icons.camera_alt_rounded,size: 20,color: Colors.black87,),
              ),
            )
          ],
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ชื่อ นามสกุล",style: TextStyle(fontSize: 15,color: Colors.black),),
            SizedBox(height: 3,),
            Text(auth.currentUser!.email.toString(),style: TextStyle(fontSize: 15,color: Colors.black),)
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              auth.signOut().then((value){
                Fluttertoast.showToast(
                    msg: 'ออกจากระบบ',
                    gravity: ToastGravity.BOTTOM
                );
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn_page())
                );
              });
            },
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(math.pi),
                child: Icon(Icons.logout, size: 25,color: Colors.black,),
              ),
            ),
          )
        ],
        shape: Border.all(color: Colors.black,width: 1.5),
      ),
      body: BlocBuilder<ListDataPokemonBloc,ListDataPokemonState>(
        bloc: _DataBloc,
        builder: (context,state){
          if (state is InitialListDataPokemonState) {
            _DataBloc!.add(IntitialPokemonEvent());
          }
          else if (state is LoadingState) {
            _widgetBox = Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is ErorState) {
            _widgetBox = Center(
              child: Text('Error'),
            );
          }
          else if (state is LoadedState) {
            _dataModel = _DataBloc!.dataModel;
            _widgetBox = SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 20,right: 20,top: 40,bottom: 50),
                      child:  GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 3/4,
                        children: List.generate(_dataModel!.results!.length, (index) {
                          return getlistPokemon(_dataModel!.results![index],);
                        }),
                      )
                  )
                ],
              ),
            );
          }
          return _widgetBox;
        },
      ),
    );
  }

  Widget getlistPokemon(item){
    var urlItem = item.url.toString(); //ประกาศตัวแปลมาเก็บ url
    var idItem = urlItem.split('/')[urlItem.split('/').length - 2]; // ดึงไอดีจาก url
    var urlImg = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${idItem}.png';
    return GestureDetector(
      onTap: (){
        // var urltest = item.url.toString();
        // var id = urltest.split('/')[urltest.split('/').length - 2];
        // print(urltest);
        // print(id);
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => Detail_Pokemon(IdPokemon: idItem,ImagPokemon : urlImg))
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5,color: Colors.black)
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: NetworkImage(urlImg,),
                    fit: BoxFit.fill,
                  ),
                  border: Border(bottom: BorderSide(width: 1.5,color: Colors.black))
                ),
              ),flex: 70,
            ),
            Expanded(child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.name.toString()),
                ],
              ),
            ),flex: 30,)
          ],
        ),
      ),
    );
  }
}
