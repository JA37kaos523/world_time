import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the UI
  String time; //time in the location
  String flag; //URL to an asset flag icon
  String url; //location url, to be added to the api endpoint
  bool isDayTime; //true or false if day time or not

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {

    try {
       //make the request
    Response response = await get('http://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    //get properties from data
    String datetime = data['datetime'];
    print(datetime);
    String offset = data['utc_offset'].substring(0, 3);

    //create DateTime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    isDayTime = now.hour > 6 && now.hour < 18 ? true : false;

    time = DateFormat.jm().format(now); // set time property
    
    

    } catch (e) {
      print('error caught: $e');
      time = 'no time data available';
    }
   
  }
  

}

