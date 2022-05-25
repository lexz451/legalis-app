class Resource<T> {
  ResourceState state;
  T? data;
  String? exception;

  Resource(this.state, {this.data, this.exception});

  static Resource<T> loading<T>({T? data}) {
    return Resource(ResourceState.loading, data: data);
  }

  static Resource<T> complete<T>(T data) {
    return Resource(ResourceState.complete, data: data);
  }

  static Resource<T> error<T>(String e, {T? data}) {
    return Resource(ResourceState.error, exception: e, data: data);
  }
}

enum ResourceState { loading, complete, error }
