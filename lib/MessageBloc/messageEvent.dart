abstract class messageEvent{}

class onmessageClicked extends messageEvent{
  String messageid;
  onmessageClicked(this.messageid);
}

class messagfetchEvent extends messageEvent{

}