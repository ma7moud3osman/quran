abstract class RepoResult<T> {
  const RepoResult();
}

class RepoSuccess<T> extends RepoResult<T> {
  final T data;
  const RepoSuccess(this.data);
}

class RepoFailure<T> extends RepoResult<T> {
  final String message;
  const RepoFailure(this.message);
}

abstract class BaseRepository {
  Future<RepoResult<T>> execute<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return RepoSuccess(result);
    } catch (e) {
      return RepoFailure(e.toString());
    }
  }
}
