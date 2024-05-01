import 'dart:developer';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/domain/usecase/project/delete_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/project/get_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/post_company_projects_usecase.dart';
import 'package:boilerplate/domain/usecase/project/update_company_project_usecase.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'project_company_store.g.dart';

class ProjectCompanyStore = _ProjectCompanyStore with _$ProjectCompanyStore;

abstract class _ProjectCompanyStore with Store {
  final GetCompanyProjectsUseCase _getCompanyProjectsUseCase;
  final PostCompanyProjectsUseCase _postCompanyProjectsUseCase;
  final UpdateProjectsUseCase _updateProjectsUseCase;
  final DeleteProjectsUseCase _deleteProjectsUseCase;

  final ErrorStore errorStore;
  _ProjectCompanyStore(
      this._getCompanyProjectsUseCase,
      this._postCompanyProjectsUseCase,
      this._updateProjectsUseCase,
      this._deleteProjectsUseCase,
      this.errorStore);

  static ObservableFuture<ProjectList?> emptyProfileResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<ProjectList?> fetchCompanyProjectFuture =
      ObservableFuture<ProjectList?>(emptyProfileResponse);

  @observable
  ProjectList? companyProjects;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchCompanyProjectFuture.status == FutureStatus.pending;

  @action
  Future getCompanyProjects() async {
    final future = _getCompanyProjectsUseCase.call(params: null);
    fetchCompanyProjectFuture = ObservableFuture(future);

    future.then((companyProjects) {
      this.companyProjects = companyProjects;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future postCompanyProjects(String title, int scopeType, int studentNumber,
      String describeProject) async {
    final newProject = await _postCompanyProjectsUseCase.call(
        params: PostcompanyProjectParams(
            title: title,
            scopeType: scopeType,
            studentNumber: studentNumber,
            describeProject: describeProject));
    companyProjects?.projects!.add(newProject);
    log(companyProjects!.projects!.length.toString());
  }

  @action
  Future updateCompanyProjects(Project project) async {
    final updatedProject = await _updateProjectsUseCase.call(params: project);
    final index =
        companyProjects?.projects?.indexWhere((p) => p.id == project.id);
    if (index != null && index >= 0) {
      final x = companyProjects?.projects;
      x![index] = updatedProject;
      final updatedCompanyProjects = x;
      final newProjectList = ProjectList(projects: updatedCompanyProjects);
      companyProjects = newProjectList;
    }
  }

  @action
  Future deleteCompanyProjects(int projectId) async {
    log("delete project id: $projectId");
    await _deleteProjectsUseCase.call(params: projectId);
    final x = companyProjects!.projects!;
    final updatedCompanyProjects = x;
    updatedCompanyProjects.removeWhere((p) => p.id == projectId);
    final newProjectList = ProjectList(projects: updatedCompanyProjects);
    companyProjects = newProjectList;
    log("company projects:");
    log(companyProjects!.projects!.length.toString());
  }

  @action
  refreshCompanyProjects() {
    companyProjects = null;
    success = false;
    errorStore.errorMessage = "";
    getCompanyProjects();
  }
}
