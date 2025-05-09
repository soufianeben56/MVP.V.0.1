enum BLEType {
  write("01"),
  read("02"),
  notify("03");
  // writeLinks("writeLinks"),
  // readLinks("readLinks"),
  // writeImages("writeImages"),
  // readImages("readImages"),
  // writeEvent("writeEvents"),
  // readEvent("readImages");

  final String value;

  const BLEType(this.value);
}

enum BLECommandStatus {
  success(0),
  commandNotSupported(1),
  busy(2),
  iDNotSupported(3),
  wrongIDValue(4),
  iDValueOutRange(5),
  iDValueNotSupported(6),
  iDNotWritable(7),
  iDNotReadable(8),
  iDNotApplicable(9),
  internalError(10);

  final int value;

  const BLECommandStatus(this.value);
}

enum BLECommandType {
  notes(1),
  event(2),
  link(3),
  image(4),
  weather(5),
  syncTime(6),
  syncLocation(7),
  settings(8);
  final int? value;

  const BLECommandType(this.value);
}

enum BLEMediaType {
  image(1),
  video(2),
  gif(3);
  final int? value;

  const BLEMediaType(this.value);
}