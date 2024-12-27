abstract class profilecubitState{}

class cubitinitialState extends profilecubitState{}

class profilePostDatatReceived extends profilecubitState{
  List<dynamic> postList = [];
  profilePostDatatReceived(this.postList);
}

class profilePostError extends profilecubitState{}