import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/entities/categories_items_entities.dart';
import 'package:restaurant_dashboard/features/menuItem/domain/repository/base_menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit(this.repo) : super(MenuInitial());
  final BaseMenuRepository repo;
  List<CategoriesItemEntity> itemsCategories = [];
  Future getItemCategoriesData({
    required String id,
    required String items,
  }) async {
    emit(GetItemCategoriesDataLoadingState());
    final response = await repo.getCategoriesItem(id: id, items: items);
    response.fold(
      (l) {
        emit(GetItemCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        itemsCategories = r;
        getSubCategoriesData(
            id: itemsCategories[0].category!, items: 'subCategory');
        emit(GetItemCategoriesDataSuccessState());
      },
    );
  }

  List<CategoriesItemEntity> subCategories = [];
  Future getSubCategoriesData({
    required String id,
    required String items,
  }) async {
    emit(GetItemCategoriesDataLoadingState());
    final response = await repo.getCategoriesItem(id: id, items: items);
    response.fold(
      (l) {
        emit(GetItemCategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        subCategories = r;
        emit(GetItemCategoriesDataSuccessState());
      },
    );
  }
}
