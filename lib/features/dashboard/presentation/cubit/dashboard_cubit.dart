import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_dashboard/features/dashboard/data/model/categories_model.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/categories_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/entities/item_entities.dart';
import 'package:restaurant_dashboard/features/dashboard/domain/repository/base_dashboard_repository.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit(this.repo) : super(DashboardInitial());
  final BaseDashboardRepository repo;
  List<CategoriesEntities> categories = [];
  Future getCategoriesData() async {
    emit(CategoriesDataLoadingState());
    final response = await repo.getCategoriesData();
    response.fold(
      (l) {
        emit(CategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        categories = r.take(6).toList();
        emit(CategoriesDataSuccessState());
      },
    );
  }

  List<ItemsEntities> items = [];

  Future getItemsData() async {
    emit(CategoriesDataLoadingState());
    final response = await repo.getItemsData();
    response.fold(
      (l) {
        emit(CategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        items = r.take(6).toList();
        emit(CategoriesDataSuccessState());
      },
    );
  }

  int reviewsNumber = 0;
  Future reviewsCount() async {
    emit(CategoriesDataLoadingState());
    final response = await repo.reviewsCount();
    response.fold(
      (l) {
        emit(CategoriesDataFailedState(message: l.message));
        Logger().e(l.message);
      },
      (r) async {
        reviewsNumber = r;
        emit(CategoriesDataSuccessState());
      },
    );
  }
}
