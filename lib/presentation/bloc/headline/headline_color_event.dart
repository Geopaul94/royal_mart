// Events
abstract class ContainerEvent {}
class SelectContainerEvent extends ContainerEvent {
  final int index;
  SelectContainerEvent(this.index);
}