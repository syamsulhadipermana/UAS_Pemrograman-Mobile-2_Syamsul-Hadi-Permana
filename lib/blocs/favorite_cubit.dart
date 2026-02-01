import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(int guitarId) {
    final currentFavorites = List<int>.from(state);

    if (currentFavorites.contains(guitarId)) {
      currentFavorites.remove(guitarId);
    } else {
      currentFavorites.add(guitarId);
    }

    emit(currentFavorites);
  }

  bool isFavorite(int guitarId) {
    return state.contains(guitarId);
  }

  void addFavorite(int guitarId) {
    if (!state.contains(guitarId)) {
      emit([...state, guitarId]);
    }
  }

  void removeFavorite(int guitarId) {
    final newList = state.where((id) => id != guitarId).toList();
    emit(newList);
  }

  void clearFavorites() {
    emit([]);
  }
}
