import 'package:event_bus/event_bus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum StackType {
  MAIN,
  START_PAGE
}
/*
 * All Events are maintainded here.
 */
class SwitchStackEvent {
  StackType type; 
  int stackIndex;

  SwitchStackEvent(this.type, this.stackIndex);
}

class TakePictureEvent {}

class CompressPictureEvent {
  String imagePath;

  CompressPictureEvent(this.imagePath);
}

class ShowPictureEvent {
  String imagePath;

  ShowPictureEvent(this.imagePath);
}

class SaveGardenEvent {}

class AddGardenEvent {}

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
  static void fireSwitchStack(StackType type, int index) =>
      _sEventBus.fire(new SwitchStackEvent(type, index));
  static void fireTakePicture() => _sEventBus.fire(new TakePictureEvent());
  static void fireShowPicture(String imagePath) =>
      _sEventBus.fire(new ShowPictureEvent(imagePath));
  static void fireCompressPicture(String imagePath) =>
      _sEventBus.fire(new CompressPictureEvent(imagePath));
  static void fireSaveGarden() => _sEventBus.fire(SaveGardenEvent());
  static void fireAddGarden() => _sEventBus.fire(AddGardenEvent());
  static void fireMarkersReady(Set<Marker> markers) => _sEventBus.fire(MarkersReadyEvent(markers));
  static void fireGardenSelected() => _sEventBus.fire(GardenSelectedEvent());

  //--
  static void onSwitchTask(OnSwichTaskFunc func) =>
      _sEventBus.on<SwitchStackEvent>().listen((event) => func(event));

  static void onTakePicture(OnTakePictureFunc func) =>
      _sEventBus.on<TakePictureEvent>().listen((event) => func(event));

  static void onShowPicture(OnShowPictureFunc func) =>
      _sEventBus.on<ShowPictureEvent>().listen((event) => func(event));

  static void onCompressPicture(OnCompressPictureFunc func) =>
      _sEventBus.on<CompressPictureEvent>().listen((event) => func(event));

  static void onSaveGarden(OnSaveGardenFunc func) =>
      _sEventBus.on<SaveGardenEvent>().listen((event) => func(event));

  static void onAddGarden(OnAddGardenFunc func) =>
      _sEventBus.on<AddGardenEvent>().listen((event) => func(event));

  static void onMarkersReady(OnMarkersReadyFunc func) =>
      _sEventBus.on<MarkersReadyEvent>().listen((event) => func(event));

  static void onGardenSelected(OnMarkerSelectedFunc func) =>
      _sEventBus.on<GardenSelectedEvent>().listen((event) => func(event));
}

typedef void OnSwichTaskFunc(SwitchStackEvent event);
typedef void OnTakePictureFunc(TakePictureEvent event);
typedef void OnShowPictureFunc(ShowPictureEvent event);
typedef void OnCompressPictureFunc(CompressPictureEvent event);
typedef void OnSaveGardenFunc(SaveGardenEvent event);
typedef void OnAddGardenFunc(AddGardenEvent event);
typedef void OnMarkersReadyFunc(MarkersReadyEvent event);
typedef void OnMarkerSelectedFunc(GardenSelectedEvent event);
