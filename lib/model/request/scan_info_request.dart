class ScanInfoRequest {
  String barcodeId;

  ScanInfoRequest({required this.barcodeId});

  Map<String, dynamic> tojson() => {
        'barcode_id': this.barcodeId,
      };
}
