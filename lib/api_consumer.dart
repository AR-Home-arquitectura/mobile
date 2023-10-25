import 'dart:typed_data';
import 'package:arhome/global.dart';
import 'package:http/http.dart' as http;

class ApiConsumer {
  Future<Uint8List> removeImageBackgroundApi(String imagePath) async{

    //request
     var requestApi =  http.MultipartRequest(
      "POST",
      Uri.parse("https://api.remove.bg/v1.0/removebg")
    );

      //definir qué imagen se manda a la api
     requestApi.files.add(
       await http.MultipartFile.fromPath(
         "image_file",
         imagePath
       )
     );


     //pi header - comunicar con la api key
     requestApi.headers.addAll({
       "X-API-Key" : apiKeyRemoveImageBackground
     });

     //enviar la petición y recibir respuesta
     final responseFromApi = await requestApi.send();

     if(responseFromApi.statusCode == 200)
     {
       http.Response getTransparentImageFromResponse = await http.Response.fromStream(responseFromApi);
       return getTransparentImageFromResponse.bodyBytes;
     }
     else
     {
       throw Exception("Error Occured:: " + responseFromApi.statusCode.toString());
     }
  }
}