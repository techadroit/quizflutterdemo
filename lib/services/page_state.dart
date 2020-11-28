
import 'package:equatable/equatable.dart';

class PageState extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class NextPage extends PageState {
  int index;

  NextPage(this.index);

  @override
  List<Object> get props => [index];
}

class PrevPage extends PageState {
  int index;

  PrevPage(this.index);

  @override
  List<Object> get props => [index];
}

class PageFinished extends PageState {
  int marks;
  int total;

  PageFinished(this.marks, this.total);
}
