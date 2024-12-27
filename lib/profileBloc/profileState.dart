import 'package:demo_chat/Model/profileDetailModel.dart';

abstract class profileState{}

class profileinitState extends profileState{
  profileinitState(ProfileDetailModel profiledetail);
}

class profileDateReceived extends profileState{
  ProfileDetailModel profileDetails;
  bool isfollowing = false;
  bool isfollower = false;
  profileDateReceived(this.profileDetails,this.isfollower,this.isfollowing);
}

class profileErrorresponse extends profileState{

}