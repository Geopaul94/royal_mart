abstract class ImageEvent {}

class LoadImages extends ImageEvent {
  final int page;

  LoadImages(this.page);
}
