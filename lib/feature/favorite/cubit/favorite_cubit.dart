import 'package:bloc/bloc.dart';
import 'package:state_mangement/feature/favorite/cubit/favorite_state.dart';
import 'package:state_mangement/feature/favorite/model/favorateData.dart';



class FavCubit extends Cubit<FavState> {
  FavCubit() : super(FavInitial());

  addFavoriteCubit({required String id})async{
   await DataFavorite.addFavorite(id: id);
    emit(FavAddSuccessState());
    getFavoriteCubit();
  }
  deleteFavoriteCubit({required String id})async{
   await DataFavorite.deleteFavorite(id: id);
    emit(FavDeleteSuccessState());
    getFavoriteCubit();
  }


  getFavoriteCubit()async{
    var list = await DataFavorite.getFavorite();
    emit(FavGetSuccessState(product: list));
  }

}