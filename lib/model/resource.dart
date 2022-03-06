class Resource<T> {
  ResourceState state;
  T? data;
  String? exception;

  Resource(this.state, {this.data, this.exception});

  static Resource<T> loading<T>() {
    return Resource(ResourceState.loading);
  }

  static Resource<T> complete<T>(T data) {
    return Resource(ResourceState.complete, data: data);
  }

  static Resource<T> error<T>(String e) {
    return Resource(ResourceState.error, exception: e);
  }
}

enum ResourceState { loading, complete, error }
