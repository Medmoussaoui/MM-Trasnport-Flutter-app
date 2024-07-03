abstract class RefrechSmart<T> {
  List<T> newItems = [];
  List<T> remoteData = [];
  List<dynamic> matched = [];

  Future<String> onMatched(T item);

  Future<int> update(T item);

  Future<int> insert(T item);

  Future<void> delete(List<dynamic> matchedData);

  Future<bool> isNeedSync(T item);

  void newItem(T item) => newItems.add(item);

  Future<void> _matched(T item) async {
    final ref = await onMatched(item);
    matched.add(ref);
  }

  Future<List<T>> _update() async {
    for (T item in remoteData) {
      bool needSync = await isNeedSync(item);
      if (needSync) {
        await _matched(item);
        continue;
      }
      int result = await update(item);
      if (result == 1) await _matched(item);
      if (result == 0) newItem(item);
    }
    return newItems;
  }

  Future<void> _insert() async {
    for (T item in newItems) {
      await insert(item);
      await _matched(item);
    }
  }

  Future<void> refrech(List<T> data) async {
    remoteData = data;
    await _update();
    if (newItems.isNotEmpty) await _insert();
    await delete(matched);
  }
}
