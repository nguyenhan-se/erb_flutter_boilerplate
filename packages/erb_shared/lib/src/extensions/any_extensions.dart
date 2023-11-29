extension ScopeFunctionsForObject<T extends Object> on T {
  R let<R>(R Function(T it) block) => block(this);

  T also(void Function(T it) block) {
    block(this);

    return this;
  }

  T? takeIf(bool Function(T it) block) => block(this) ? this : null;

  T2? tryCast<T2 extends T>() => this is T2 ? this as T2 : null;
}
