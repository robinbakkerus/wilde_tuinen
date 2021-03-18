import 'package:event_bus/event_bus.dart';

/*
 * All Events are maintainded here.
 */
class SwitchStackEvent {
  int stackIndex;
  SwitchStackEvent(this.stackIndex);
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

//--- AppEvents
class AppEvents {
  static final EventBus _sEventBus = new EventBus();

  // Only needed if clients want all EventBus functionality.
  static EventBus ebus() => _sEventBus;

  /*
  * The methods below are just convenience shortcuts to make it easier for the client to use.
  */
  static void fireSwitchStack(int index) =>
      _sEventBus.fire(new SwitchStackEvent(index));
  static void fireTakePicture() => _sEventBus.fire(new TakePictureEvent());
  static void fireShowPicture(String imagePath) =>
      _sEventBus.fire(new ShowPictureEvent(imagePath));
  static void fireCompressPicture(String imagePath) =>
      _sEventBus.fire(new CompressPictureEvent(imagePath));
  static void fireSaveGarden() => _sEventBus.fire(new SaveGardenEvent());
  static void fireAddGarden() => _sEventBus.fire(new AddGardenEvent());

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
}

typedef void OnSwichTaskFunc(SwitchStackEvent event);
typedef void OnTakePictureFunc(TakePictureEvent event);
typedef void OnShowPictureFunc(ShowPictureEvent event);
typedef void OnCompressPictureFunc(CompressPictureEvent event);
typedef void OnSaveGardenFunc(SaveGardenEvent event);
typedef void OnAddGardenFunc(AddGardenEvent event);
