// ignore_for_file: prefer_const_constructors, constant_identifier_names
// Rev 3 – 2025‑05‑01
// * Reset‑Problem behoben: Sobald die ankommenden Listen **leer** sind,
//   wird Snapshot & Freeze zurückgesetzt → Reset‑Button löscht jetzt sofort.
// * Axis‑Freeze bleibt nur, solange die Listen **wachsen**. Bei
//   Stop‑→‑Start beginnt ein neuer Sweep ohne verformen.
// * Glättung: zusätzlicher Running‑Average (3er‑Fenster) vor Catmull‑Rom.
// * Achsenbeschriftungen (V & mA) + dynamische Ticks.
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DiodeGraph extends StatefulWidget {
  const DiodeGraph({
    super.key,
    required this.voltageData,
    required this.currentData,
    this.lineWidth = 2.0,
    this.lineColor = Colors.blue,
    this.gridColor = const Color(0xFFDDDDDD),
    this.labelColor = Colors.black,
    this.freezeAfterMs = 800,
  }) : assert(voltageData.length == currentData.length);

  final List<double> voltageData;
  final List<double> currentData;
  final double lineWidth;
  final Color lineColor;
  final Color gridColor;
  final Color labelColor;
  final int freezeAfterMs;

  @override
  State<DiodeGraph> createState() => _DiodeGraphState();
}

class _DiodeGraphState extends State<DiodeGraph> {
  late DateTime _lastUpdate;
  double? _vMinF, _vMaxF, _iMaxF; // frozen axis
  List<double>? _vSnap, _iSnap;   // snapshot when frozen

  @override
  void initState() {
    super.initState();
    _lastUpdate = DateTime.now();
  }

  @override
  void didUpdateWidget(covariant DiodeGraph old) {
    super.didUpdateWidget(old);

    // Wenn beide Listen geleert wurden (Reset‑Button) ➜ alles zurücksetzen
    if (widget.voltageData.isEmpty && widget.currentData.isEmpty) {
      _vSnap = _iSnap = null;
      _vMinF = _vMaxF = _iMaxF = null;
      return;
    }

    // Neue Punkte angekommen?
    if (widget.voltageData.length != old.voltageData.length) {
      _lastUpdate = DateTime.now();
      // Falls neuer Sweep (Listenlänge < vorher) ➜ Freeze lösen
      if (widget.voltageData.length < old.voltageData.length) {
        _vSnap = _iSnap = null;
        _vMinF = _vMaxF = _iMaxF = null;
      }
    }
  }

  bool get _frozen =>
      DateTime.now().difference(_lastUpdate).inMilliseconds > widget.freezeAfterMs;

  @override
  Widget build(BuildContext context) {
    // Snapshot & Freeze erstellen
    if (_frozen && _vSnap == null && widget.voltageData.isNotEmpty) {
      _vSnap = List<double>.from(widget.voltageData);
      _iSnap = List<double>.from(widget.currentData);
      _vMinF = _vSnap!.first;
      _vMaxF = _vSnap!.last;
      _iMaxF = _iSnap!.reduce(math.max);
    }

    // dyn. Y‑Grow
    if (_vSnap != null && widget.currentData.isNotEmpty) {
      final peak = widget.currentData.reduce(math.max);
      if (peak > (_iMaxF ?? 0)) _iMaxF = peak;
    }

    final srcV = _vSnap ?? widget.voltageData;
    final srcI = _vSnap != null ? _iSnap! : widget.currentData;

    final vMin = _vMinF ?? (srcV.isEmpty ? 0.0 : srcV.first);
    final vMax = _vMaxF ?? (srcV.isEmpty ? 1.0 : srcV.last);
    final iMax = _iMaxF ?? (srcI.isEmpty ? 1.0 : srcI.reduce(math.max));

    return LayoutBuilder(
      builder: (context, c) => CustomPaint(
        size: Size(c.maxWidth, c.maxHeight),
        painter: _Painter(
          v: srcV,
          i: srcI,
          vMin: vMin,
          vMax: vMax,
          iMax: iMax,
          lineWidth: widget.lineWidth,
          lineColor: widget.lineColor,
          gridColor: widget.gridColor,
          labelColor: widget.labelColor,
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  _Painter({
    required List<double> v,
    required List<double> i,
    required this.vMin,
    required this.vMax,
    required this.iMax,
    required this.lineWidth,
    required this.lineColor,
    required this.gridColor,
    required this.labelColor,
  })  : vData = _avgN(v, 6),
        iData = _avgN(i, 6);

  // Running average (Fenster N, default 5) für Glättung vor Spline
  static List<double> _avgN(List<double> src, [int n = 6]) {
    if (src.length < n) return src;
    final out = <double>[];
    for (int k = 0; k < src.length; k++) {
      double sum = 0; int cnt = 0;
      for (int j = k - n + 1; j <= k; j++) {
        if (j < 0 || j >= src.length) continue;
        sum += src[j]; cnt++;
      }
      out.add(sum / cnt);
    }
    return out;
  }

  final List<double> vData;
  final List<double> iData;
  final double vMin, vMax, iMax;
  final double lineWidth;
  final Color lineColor;
  final Color gridColor;
  final Color labelColor;

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(color: labelColor, fontSize: 11);

    // Grid & ticks
    const n = 4;
    final grid = Paint()
      ..color = gridColor
      ..style = PaintingStyle.stroke;
    for (int k = 1; k < n; k++) {
      final dy = size.height * k / n;
      final dx = size.width * k / n;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), grid);
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), grid);

      // y‑Labels (mA)
      final iLabel = (iMax * (1 - k / n)) * 1000; // A → mA
      final txt = '${iLabel.toStringAsFixed(0)}';
      final tp = TextPainter(text: TextSpan(text: txt, style: textStyle),
          textDirection: TextDirection.ltr)..layout();
      tp.paint(canvas, Offset(2, dy - tp.height / 2));

      // x‑Labels (V)
      final vLabel = vMin + (vMax - vMin) * k / n;
      final txtX = '${vLabel.toStringAsFixed(2)}';
      final tpX = TextPainter(text: TextSpan(text: txtX, style: textStyle),
          textDirection: TextDirection.ltr)..layout();
      tpX.paint(canvas, Offset(dx - tpX.width / 2, size.height + 2));
    }

    // Axes
    final axis = Paint()
      ..color = labelColor
      ..strokeWidth = 1.2;
    canvas.drawLine(Offset(0, size.height), Offset(size.width, size.height), axis);
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), axis);

    // Draw axis unit labels (once)
    final yUnit = TextPainter(
      text: TextSpan(text: 'mA', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    yUnit.paint(canvas, Offset(2, 2));

    final xUnit = TextPainter(
      text: TextSpan(text: 'V', style: textStyle.copyWith(fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    xUnit.paint(canvas, Offset(size.width - xUnit.width - 2, size.height + 16));

    if (vData.length < 2) return;

    // Map data → canvas
    List<Offset> pts = List<Offset>.generate(vData.length, (ix) {
      final x = (vData[ix] - vMin) / (vMax - vMin) * size.width;
      final y = size.height - (iData[ix] / iMax) * size.height;
      return Offset(x, y);
    });

    final curve = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()..moveTo(pts.first.dx, pts.first.dy);
    for (int i = 0; i < pts.length - 1; i++) {
      final p0 = i == 0 ? pts[i] : pts[i - 1];
      final p1 = pts[i];
      final p2 = pts[i + 1];
      final p3 = i + 2 < pts.length ? pts[i + 2] : p2;
      for (double t = 0; t < 1; t += 0.02) {
        final tt = t * t;
        final ttt = tt * t;
        final qx = 0.5 * ((2 * p1.dx) + (-p0.dx + p2.dx) * t +
            (2 * p0.dx - 5 * p1.dx + 4 * p2.dx - p3.dx) * tt +
            (-p0.dx + 3 * p1.dx - 3 * p2.dx + p3.dx) * ttt);
        final qy = 0.5 * ((2 * p1.dy) + (-p0.dy + p2.dy) * t +
            (2 * p0.dy - 5 * p1.dy + 4 * p2.dy - p3.dy) * tt +
            (-p0.dy + 3 * p1.dy - 3 * p2.dy + p3.dy) * ttt);
        path.lineTo(qx, qy);
      }
    }
    path.lineTo(pts.last.dx, pts.last.dy);
    canvas.drawPath(path, curve);
  }

  @override
  bool shouldRepaint(covariant _Painter old) =>
      !listEquals(old.vData, vData) ||
      !listEquals(old.iData, iData) ||
      old.lineColor != lineColor;
}
