import 'package:demo_chat/Model/profileDetailModel.dart';

abstract class profileState{}

class profileinitState extends profileState{}

class profileDateReceived extends profileState{
  profileDateReceived(ProfileDetailModel profiledetail);
}