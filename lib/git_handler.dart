import 'dart:io';

import 'package:git_clone/git_clone.dart';
import 'package:path/path.dart' as path;
import 'package:nezumi/constants.dart';

class RepoExistsException implements Exception {
  String repo;

  RepoExistsException(this.repo);
}

class RepoCloneException implements Exception {
  String url;
  int exitCode;
  String stdout;
  String stderr;

  RepoCloneException(this.url, this.exitCode, this.stdout, this.stderr);
}

Future<String> fetchGitRepo(String gitUrl) async {
  // extract the repo name from the last slash.
  var repoName = gitUrl.substring(gitUrl.lastIndexOf("/") + 1);

  // trim .git suffix.
  if (repoName.endsWith(".git")) {
    repoName = repoName.substring(0, repoName.length - 4);
  }

  var reposPath = path.join(await localPath(), "repos");
  var thisRepoPath = path.join(reposPath, repoName);

  // check if it already exists.
  var directory = Directory(thisRepoPath);
  if (directory.existsSync()) {
    throw RepoExistsException(repoName);
  }

  // if we're here, it means that this is a new repo.
  _cloneGitRepository(gitUrl, reposPath, thisRepoPath);

  // return the repository path.
  return thisRepoPath;
}

void _cloneGitRepository(String gitUrl, String cloneDestination, String repoPath) async {
  int exitCode = 0;
  String stdout = "";
  String stderr = "";

  await gitClone(
  repo: gitUrl,
  directory: cloneDestination,
  callback: (ProcessResult r) async {
    exitCode = r.exitCode;
    stdout = r.stdout;
    stderr = r.stderr;
    if (r.exitCode != 0) {
      print("An error occurred while cloning the $gitUrl repository.\n"
          "Stdout: ${r.stdout}\nStderr: ${r.stderr}");
      return;
    }

    final destination = Directory(repoPath);
    final isThere = await destination.exists();
    if (!isThere) {
      stderr = "Repository doesn't exist after cloning!";
      print(stderr);
      exitCode = 1;
    }
  },
  );

  if (exitCode != 0) {
    throw RepoCloneException(gitUrl, exitCode, stdout, stderr);
  }
}
