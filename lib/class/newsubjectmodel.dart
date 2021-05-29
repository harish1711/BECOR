class NewSubject {
  String createduid;
  String classcode;
  String subjectcode;
  String subjectname;
  NewSubject(this.classcode, this.subjectcode, this.subjectname,this.createduid);
  Map<String, dynamic> newsubjectvalues() => {
        'Created UID':createduid,
        'Class Code': classcode,
        'Subject Code': subjectcode,
        'Subject Name': subjectname,
      };
}