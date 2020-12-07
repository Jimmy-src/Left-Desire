import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/material.dart';

class AddAddress extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final cName = TextEditingController();
    final cContactNumber = TextEditingController();
    final cAddress = TextEditingController();
    final cCity = TextEditingController();
    final cState = TextEditingController();
    final cPostCode = TextEditingController();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: MyAppBar(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            if(formKey.currentState.validate())
              {
                final model = AddressModel(
                  name: cName.text.trim(),
                  state: cState.text.trim(),
                  postcode: cPostCode.text,
                  contactNumber: cContactNumber.text,
                  address: cAddress.text,
                  city: cCity.text.trim(),
                ).toJson();

                //add to firestore
                EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
                    .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                    .collection(EcommerceApp.subCollectionAddress)
                    .document(DateTime.now().millisecondsSinceEpoch.toString())
                    .setData(model)
                    .then((value) {
                      final snack = SnackBar(content: Text("New Address added Successfully"));
                      scaffoldKey.currentState.showSnackBar(snack);
                      FocusScope.of(context).requestFocus(FocusNode());
                      formKey.currentState.reset();
                });

                Route route = MaterialPageRoute(builder: (c) => StoreHome());
                Navigator.pushReplacement(context, route);

              }
          },
          label: Text("Done"),
          backgroundColor: Colors.pink,
          icon: Icon(Icons.check),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Add New Address",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      hint: "Name",
                      controller: cName,
                    ),
                    MyTextField(
                      hint: "Contact Number",
                      controller: cContactNumber,
                    ),
                    MyTextField(
                      hint: "Address",
                      controller: cAddress,
                    ),
                    MyTextField(
                      hint: "City",
                      controller: cCity,
                    ),
                    MyTextField(
                      hint: "State",
                      controller: cState,
                    ),
                    MyTextField(
                      hint: "PostCode",
                      controller: cPostCode,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  MyTextField({Key key, this.hint, this.controller,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration.collapsed(hintText: hint),
        validator: (val) => val.isEmpty ? "Field cannot be Empty." : null,
      ),
    );
  }
}
