
abstract class cubitstate{}
class cubitinitialstate extends cubitstate{}
class cubitloadingState extends cubitstate{}
class cubitloadfailstate extends cubitstate{}
class cubitdatareceived extends cubitstate{
  List memberslist = [];
  String memberID = "";
  cubitdatareceived({this.memberslist,this.memberID});
}