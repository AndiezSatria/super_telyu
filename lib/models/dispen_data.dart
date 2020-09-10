part of 'models.dart';

class DispenData {
  String id;
  String purpose;
  DateTime begin;
  DateTime end;

  DispenData({
    this.id,
    this.purpose = '',
    this.begin,
    this.end,
  });

  Dispen convertToDispen({
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Dispen(
        dispenId: this.id,
        begin: this.begin,
        purpose: this.purpose,
        end: this.end,
        dosenVerifier: dosenVerifier,
        lkmVerifier: lkmVerifier,
      );
}
