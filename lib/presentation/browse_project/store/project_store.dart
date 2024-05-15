import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/project_2/project.dart';

part 'project_store.g.dart';

class ProjectStore = _ProjectStore with _$ProjectStore;

abstract class _ProjectStore with Store {
  _ProjectStore(this._getProjectsUseCase, this.errorStore);

  final GetProjectsUseCase _getProjectsUseCase;
  final ErrorStore errorStore;

  static ObservableFuture<ProjectList?> emptyProjectsResponse =
      ObservableFuture.value(null);

  @observable
  bool doneReloading = false;

  @observable
  ObservableFuture<ProjectList?> fetchProjectsFuture =
      ObservableFuture<ProjectList?>(emptyProjectsResponse);

  @observable
  ProjectList? projects;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchProjectsFuture.status == FutureStatus.pending;

  @action
  Future getProjects() async {
    final future = _getProjectsUseCase.call(params: null);
    fetchProjectsFuture = ObservableFuture(future);
    future.then((projectList) {
      this.projects = projectList;
      success = true;
      doneReloading = true;
    }).catchError((error) {
      errorStore.errorMessage = error.toString();
      retryGetProjects();
    });
  }

  @action
  refreshProjects() {
    projects = null;
    // success = false;
    doneReloading = false;
    errorStore.errorMessage = "";
    getProjects();
  }

  @action
  clearStoreData() {
    projects = null;
    success = false;
    doneReloading = false;
  }

  @action
  Future retryGetProjects(
      {int retries = 3, Duration delay = const Duration(seconds: 1)}) async {
    for (int i = 0; i < retries; i++) {
      await Future.delayed(delay);
      try {
        await getProjects();
        if (success) {
          break;
        }
      } catch (_) {
        if (i == retries - 1) {
          errorStore.errorMessage =
              "Failed to fetch projects after $retries retries.";
        }
      }
    }
  }
}
