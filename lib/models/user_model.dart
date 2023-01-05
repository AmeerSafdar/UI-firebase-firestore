
class UserModelClass {
    String firstName ;
    String uid;
    String lastName;
    String email;
UserModelClass({
required this.uid,
required this.email,
required this.firstName,
required this.lastName,

});

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "uid": uid,
        "email": email,
        "lastName":lastName
      };
}