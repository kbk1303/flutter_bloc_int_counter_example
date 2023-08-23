abstract class RandomNumberEvent {}

class FetchRamdomNumberEvent extends RandomNumberEvent {
  final bool? _useMockup;

  bool? get useMockup => _useMockup;

  FetchRamdomNumberEvent({bool useMockup = true}) : _useMockup = useMockup;
}
