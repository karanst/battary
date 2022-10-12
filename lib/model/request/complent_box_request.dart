class ComplentBoxRequest {
  String machanicId;
  String roleId;
  String customerid;
  String barcodeId;
  String description;
  String newBarcodeId;
  String initialId;
  ComplentBoxRequest({
    required this.machanicId,
    required this.roleId,
    required this.customerid,
    required this.barcodeId,
    required this.description,
    required this.newBarcodeId,
    required this.initialId
  });

  Map<String, dynamic> tojson() => {
        'mechanic_id': this.machanicId,
        'role_id': this.roleId,
        'user_id': this.customerid,
        'barcode_id': this.barcodeId,
        'description': this.description,
        'new_barcode_id': this.newBarcodeId,
        'initial_id': this.initialId
      };
}
