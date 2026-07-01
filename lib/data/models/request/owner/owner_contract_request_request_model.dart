import 'dart:convert';

class OwnerContractRequestActionRequestModel {
  final String? ownerNotes;

  OwnerContractRequestActionRequestModel({this.ownerNotes});

  String toJson() => jsonEncode({
    if (ownerNotes != null && ownerNotes!.isNotEmpty) 'owner_notes': ownerNotes,
  });
}
