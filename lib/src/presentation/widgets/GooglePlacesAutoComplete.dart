import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:indriver_clone_flutter/src/data/api/ApiKeyGoogle.dart';

class GooglePlacesAutoComplete extends StatelessWidget {

  TextEditingController controller;
  String hintText;
  Function(Prediction prediction) onPlaceSelected;

  GooglePlacesAutoComplete(this.controller, this.hintText, this.onPlaceSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        boxDecoration: BoxDecoration(
          color: Colors.white,
        ),
        inputDecoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["co"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: onPlaceSelected,
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
        },
        seperatedBuilder: Divider(),
        containerHorizontalPadding: 10,
        googleAPIKey: API_KEY_GOOGLE,
        // OPTIONAL// If you want to customize list view item builder
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                  child: Text(
                    "${prediction.description ?? ""}",
                  )
                )
              ],
            ),
          );
        },

        isCrossBtnShown: true,

        // default 600 ms ,
      ),
    );
  }

  
}