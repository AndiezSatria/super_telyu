part of 'models.dart';

class Dispen extends Equatable {
  final String dispenId;
  final String purpose;
  final DateTime begin;
  final DateTime end;
  final String dosenVerifier;
  final String lkmVerifier;
  Dispen({
    @required this.dispenId,
    this.purpose,
    this.begin,
    this.end,
    this.dosenVerifier,
    this.lkmVerifier,
  });
  Dispen copyWith({
    String id,
    String purpose,
    DateTime begin,
    DateTime end,
    String dosenVerifier,
    String lkmVerifier,
  }) =>
      Dispen(
        dispenId: id ?? this.dispenId,
        begin: begin ?? this.begin,
        purpose: purpose ?? this.purpose,
        end: end ?? this.end,
        dosenVerifier: dosenVerifier ?? dosenVerifier,
        lkmVerifier: lkmVerifier ?? lkmVerifier,
      );
  @override
  List<Object> get props => [
        this.dispenId,
        this.purpose,
        this.begin,
        this.end,
        this.dosenVerifier,
        this.lkmVerifier,
      ];
}
