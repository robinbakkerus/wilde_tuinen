import 'package:event_bus/event_bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wilde_tuinen/model/garden.dart';

/*
 * All Events are maintainded here.
 */
class SwitchStackEvent {
  int stackIndex;

  SwitchStackEvent(this.stackIndex);
}

class RetrieveGardensEvent {}
class GardensRetrievedEvent {}

class SaveGardenEvent {
  Garden garden;

  SaveGardenEvent(this.garden);
}

class MarkersReadyEvent {
  late Set<Marker> markers;

  MarkersReadyEvent(this.markers);
}

class GardenSelectedEvent {}

//--- AppEvents -----------------
class AppEvents {
  static final EventBus _sEventBus = new EventBus();

  // Only needed if clients want all EventBus functionality.
  static EventBus ebus() => _sEventBus;

  /*
  * The methods below are just convenience shortcuts to make it easier for the client to use.
  */
  static void fireSwitchStack(int index) => _sEventBus.fire(new SwitchStackEvent(index));
  static void fireSaveGarden(Garden garden) => _sEventBus.fire(SaveGardenEvent(garden));
  static void fireMarkersReady(Set<Marker> markers) => _sEventBus.fire(MarkersReadyEvent(markers));
  static void fireGardenSelected() => _sEventBus.fire(GardenSelectedEvent());
  static void fireRetrieveGardens() => _sEventBus.fire(RetrieveGardensEvent());
  static void fireGardensRetrieved() => _sEventBus.fire(GardensRetrievedEvent());

  //--
  static void onSwitchTask(OnSwichTaskFunc func) =>
      _sEventBus.on<SwitchStackEvent>().listen((event) => func(event));

    static void onSaveGarden(OnSaveGardenFunc func) =>
      _sEventBus.on<SaveGardenEvent>().listen((event) => func(event));

  static void onMarkersReady(OnMarkersReadyFunc func) =>
      _sEventBus.on<MarkersReadyEvent>().listen((event) => func(event));

  static void onGardenSelected(OnMarkerSelectedFunc func) =>
      _sEventBus.on<GardenSelectedEvent>().listen((event) => func(event));

  static void onRetrieveGardens(OnRetrieveGardensFunc func) =>
      _sEventBus.on<RetrieveGardensEvent>().listen((event) => func(event));

  static void onGardensRetrieved(OnGardensRetrievedFunc func) =>
      _sEventBus.on<GardensRetrievedEvent>().listen((event) => func(event));
}

typedef void OnSwichTaskFunc(SwitchStackEvent event);
typedef void OnSaveGardenFunc(SaveGardenEvent event);
typedef void OnMarkersReadyFunc(MarkersReadyEvent event);
typedef void OnMarkerSelectedFunc(GardenSelectedEvent event);
typedef void OnRetrieveGardensFunc(RetrieveGardensEvent event);
typedef void OnGardensRetrievedFunc(GardensRetrievedEvent event);
