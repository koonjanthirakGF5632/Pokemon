import 'package:flutter/material.dart';

class Detail_Pokemon extends StatefulWidget {
  Detail_Pokemon({this.IdPokemon,this.ImagPokemon});
  String? IdPokemon; //ประกาศค่าเพื่อมารับ IdPokemonด้านบน
  String? ImagPokemon; //ประกาศค่าเพื่อมารับ imaPokemonด้านบน


  @override
  _Detail_PokemonState createState() => _Detail_PokemonState(
      // id: IdPokemon
  );
}

class _Detail_PokemonState extends State<Detail_Pokemon> {
  // _Detail_PokemonState({this.id});
  // String? id;

  @override
  void initState() {
    super.initState();
    print(widget.IdPokemon);
    print(widget.ImagPokemon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);

          },),
        title:  Text('รายละเอียด',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1.5),
                shape: BoxShape.rectangle,
                color: Colors.white,
                image: DecorationImage(
                  image: NetworkImage(widget.ImagPokemon.toString(),),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("ชื่อโปเกม่อน",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 25,right: 25,top: 30,bottom: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                    Expanded(child: Text("HP",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                    Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                  ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: Text("Attack",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                      Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: Text("Defense",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                      Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: Text("Speed",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                      Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: Text("Spacial Attact",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                      Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: Text("Special Defense",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),),
                      Expanded(child: Text(": "+"",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),))
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("ข้อมูล",style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna",style: TextStyle(color: Colors.black,fontSize: 16),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
