// import 'package:boilerplate/core/stores/error/error_store.dart';
// import 'package:boilerplate/domain/entity/project_2/project_list.dart';
// import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
// import 'package:mobx/mobx.dart';

// import '../../../domain/entity/project_2/project.dart';

// part 'saved_project_store.g.dart';

// class SavedProjectStore = _SavedProjectStore with _$ProjectStore;

// abstract class _SavedProjectStore with Store {
//   _SavedProjectStore(this._getProjectsUseCase, this.errorStore);

//   final GetSavedProjectUseCase _getProjectsUseCase;
//   final ErrorStore errorStore;

//   static ObservableFuture<ProjectList?> emptyProjectsResponse =
//       ObservableFuture.value(null);

//   @observable
//   ObservableFuture<ProjectList?> fetchProjectsFuture =
//       ObservableFuture<ProjectList?>(emptyProjectsResponse);

//   @observable
//   ProjectList? projects;

//   @observable
//   bool success = false;

//   @computed
//   bool get loading => fetchProjectsFuture.status == FutureStatus.pending;

//   @action
//   Future getProjects() async {
//     final future = _getProjectsUseCase.call(params: null);
//     fetchProjectsFuture = ObservableFuture(future);
//     future.then((projectList) {
//       this.projects = projectList;
//     }).catchError((error) {
//       errorStore.errorMessage = error.toString();
//     });
//   }

//   @action
//   refreshProjects() {
//     projects = null;
//     success = false;
//     errorStore.errorMessage = "";
//     getProjects();
//   }
// }
