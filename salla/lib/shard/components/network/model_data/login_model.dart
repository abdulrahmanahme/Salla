class SallaShopCubitModel {
  bool status;
  String message;
  UserData data;
  SallaShopCubitModel.fromjson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data =
        jsonData['data'] != null ? UserData.fromjson(jsonData['data']) : null;
  }
}

class UserData {
  int id;
  String name;
  String image;
  String email;
  String phone;
  int points;
  int credit;
  String token;
  UserData.fromjson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    image = jsonData['image'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    points = jsonData['points'];
    credit = jsonData['credit'];
    token = jsonData['token'];
  }
}
