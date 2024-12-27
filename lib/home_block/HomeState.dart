import 'package:equatable/equatable.dart';
abstract class homestate extends Equatable{}

class Homeinitialize extends homestate{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

abstract class Homeaction extends homestate{}

class Homeloadingstate extends homestate{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeDatareceivedsuccess extends homestate{
  List postList = [];
  HomeDatareceivedsuccess(this.postList);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class HomeDatareceiveError extends homestate{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}