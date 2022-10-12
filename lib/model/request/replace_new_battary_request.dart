class ReplaceBattaryRequest {
  String newBarcodeId;
  String oldBarcodeId;
  String userId;
  ReplaceBattaryRequest(
      {required this.newBarcodeId, required this.oldBarcodeId,required this.userId});

  Map<String, dynamic> tojson() => {
        'Newbarcode_id': this.newBarcodeId,
        'barcode_id': this.oldBarcodeId,
    'barcodes_id': this.oldBarcodeId,
    'user_id': this.oldBarcodeId,
      };
}
