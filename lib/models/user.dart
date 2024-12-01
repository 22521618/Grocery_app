import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }

  //Converr map to json String
  //THe json.encode() function converts a Dart object such as Map or List
  String toJson() => json.encode(toMap());

  // Deserialization: Chuyển đổi một Map thành một đối tượng User
  // Mục đích - Thao tác và sử dụng: Một khi dữ liệu được chuyển đổi thành một đối tượng User,
  // nó có thể dễ dàng thao tác và sử dụng trong ứng dụng. Ví dụ:
  // Chúng ta có thể hiển thị tên đầy đủ, email của người dùng trên giao diện người dùng, hoặc
  // chúng ta có thể lưu dữ liệu cục bộ.

  //from Map to Object

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  //from json to map
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
