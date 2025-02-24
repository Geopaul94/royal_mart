

import '../../../data/model/photo_model.dart';

abstract class ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  final List<ImageModel> images;
  
  final bool hasReachedMax;

  ImageLoaded(this.images, this.hasReachedMax);
}

class ImageError extends ImageState {}
