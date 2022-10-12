class IssueHistoryRequest {
  String barcodeId;
  String userId;

  IssueHistoryRequest({required this.userId, required this.barcodeId});

  Map<String, dynamic> tojson() => {
        'barcode_id': this.barcodeId,
        'user_id': this.userId
      };
}
