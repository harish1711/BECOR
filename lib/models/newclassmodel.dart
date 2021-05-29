class Newclass {
  String classcode;
  String classname;
  String createdbyuid;
  Newclass(this.classcode, this.classname, this.createdbyuid);
  Map<String, dynamic> newuservalues() => {
        'Class Code': classcode,
        'Class Name': classname,
        'CreatedUserUid': createdbyuid,
      };
}
