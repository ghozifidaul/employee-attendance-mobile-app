import 'package:maps_toolkit/maps_toolkit.dart';

class CekLokasi {
  double? latTitikSekarang;
  double? lngTitikSekarang;
  List<double>? listLatPolygon;
  List<double>? listLngPolygon;
  List<LatLng> listPolygonPoints = [];

  CekLokasi({
    this.latTitikSekarang,
    this.lngTitikSekarang,
    this.listLatPolygon,
    this.listLngPolygon,
  });

  bool apakahLokasiDalamPolygon() {
    if (listLatPolygon != null && listLngPolygon != null) {
      for (var i = 0; i < listLatPolygon!.length; i++) {
        listPolygonPoints.add(LatLng(listLatPolygon![i], listLngPolygon![i]));
      }

      return PolygonUtil.containsLocation(
        LatLng(latTitikSekarang!, lngTitikSekarang!),
        listPolygonPoints,
        true,
      );
    } else {
      return false;
    }
  }
}
