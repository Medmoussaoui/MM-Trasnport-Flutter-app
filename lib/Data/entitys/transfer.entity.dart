class TransferResult {
  final int unKnowTables;
  final int knowTables;
  final int total;

  factory TransferResult.fromJson(dynamic data) {
    return TransferResult(
      knowTables: data["knownTables"],
      unKnowTables: data["unknownTables"],
      total: data["total"],
    );
  }

  TransferResult({
    required this.unKnowTables,
    required this.knowTables,
    required this.total,
  });
}
