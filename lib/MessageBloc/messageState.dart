abstract class messageState{}

class initialmessagestate extends messageState{

}

class messagelistfetched extends messageState{
  List msgList = [];
  messagelistfetched(this.msgList);
}

class messagefetchfailed extends messageState{}

class messageloading extends messageState{}