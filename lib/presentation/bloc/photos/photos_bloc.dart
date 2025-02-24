
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:royalmart/data/repository/photo_fetching.dart';
import 'package:royalmart/presentation/bloc/photos/photos_event.dart';
import 'package:royalmart/presentation/bloc/photos/photos_state.dart';

// reversing the images 

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final PexelsApiService pexelsApiService;
  int page = 1;
  bool isFetching = false;

  ImageBloc(this.pexelsApiService) : super(ImageLoading()) {
    on<LoadImages>((event, emit) async {
      if (isFetching) return;
      isFetching = true;

      try {
        final images = await pexelsApiService.fetchClothingModelImages(event.page);
        if (images.isEmpty) {
//here I reversed the image

          emit(ImageLoaded(state is ImageLoaded ? (state as ImageLoaded).images.reversed.toList() : [], true));
        } else {
          final updatedImages = state is ImageLoaded ? (state as ImageLoaded).images + images : images;
        


 emit(
            ImageLoaded(
              updatedImages.reversed.toList(),
              false, 
            ),
          );
          page++; 
        }
      } catch (error) {
        emit(ImageError());
      } finally {
        isFetching = false;
      }
    });
  }
}

