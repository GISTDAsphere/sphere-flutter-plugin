import 'package:flutter/material.dart';

import 'package:sphere_maps_flutter/sphere_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final map = GlobalKey<SphereMapState>();
  final GlobalKey<ScaffoldMessengerState> messenger =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    Object? marker;

    return MaterialApp(
      scaffoldMessengerKey: messenger,
      home: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SphereMapWidget(
              apiKey: "",
              bundleId: "",
              key: map,
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Text(
                  "Layer",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        var layer = map.currentState?.SphereObject(
                          "Layer",
                          args: [
                            "roadnet2:Road_FGDS",
                            {
                              "type": map.currentState?.SphereStatic(
                                "LayerType",
                                "WMS",
                              ),
                              "url":
                                  'https://apix.longdo.com/vector/test-tile.php',
                              "zoomRange": {
                                "min": 1,
                                "max": 9,
                              },
                              "refresh": 180,
                              "opacity": 0.5,
                              "weight": 10,
                              "bound": {
                                "minLon": 100,
                                "minLat": 10,
                                "maxLon": 105,
                                "maxLat": 20
                              }
                            }
                          ],
                        );
                        if (layer != null) {
                          map.currentState?.call("Layers.add", args: [layer]);
                        }
                      },
                      child: Text("WMS"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var layer = map.currentState?.SphereObject(
                          "Layer",
                          args: [
                            "roadnet2:Road_FGDS@EPSG:900913@png",
                            {
                              "type": map.currentState?.SphereStatic(
                                "LayerType",
                                "TMS",
                              ),
                              "url":
                                  "https://apix.longdo.com/vector/test-tile.php?tms=",
                              "zoomOffset": 0,
                            }
                          ],
                        );
                        if (layer != null) {
                          map.currentState?.call("Layers.add", args: [layer]);
                        }
                      },
                      child: Text("TMS"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var layer = map.currentState?.SphereObject(
                          "Layer",
                          args: [
                            "roadnet2:Road_FGDS",
                            {
                              "type": map.currentState?.SphereStatic(
                                "LayerType",
                                "WMTS",
                              ),
                              "url":
                                  "https://apix.longdo.com/vector/test-tile.php",
                              "srs": "EPSG:900913",
                              "tileMatrix": "(z) => 'EPSG:900913:' + z",
                            }
                          ],
                        );
                        if (layer != null) {
                          map.currentState?.call("Layers.add", args: [layer]);
                        }
                      },
                      child: Text("WMTS"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var layer = map.currentState?.SphereObject(
                          "Layer",
                          args: [
                            "bluemarble_terrain",
                            {
                              "type": map.currentState?.SphereStatic(
                                "LayerType",
                                "WMTS_REST",
                              ),
                              "url": "https://ms.longdo.com/mapproxy/wmts",
                              "srs": "GLOBAL_WEBMERCATOR",
                            }
                          ],
                        );
                        if (layer != null) {
                          map.currentState?.call("Layers.add", args: [layer]);
                        }
                      },
                      child: Text("WMTS REST"),
                    ),
                  ],
                ),
                Text(
                  "Marker",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        marker ??= map.currentState?.SphereObject(
                          "Marker",
                          id: "basic",
                          args: [
                            {
                              "lon": 100.56,
                              "lat": 13.74,
                            }
                          ],
                        );
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [marker!]);
                        }
                      },
                      child: Text("Add"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.remove", args: [marker!]);
                        }
                      },
                      child: Text("Remove"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        map.currentState?.call("Overlays.clear");
                      },
                      child: Text("Clear"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        var marker = map.currentState?.SphereObject(
                          "Marker",
                          args: [
                            {
                              "lon": 101.2,
                              "lat": 12.8,
                            },
                            {
                              "title": "Marker",
                              "detail": "Drag me",
                              "visibleRange": {
                                "min": 7,
                                "max": 9,
                              },
                              "draggable": true
                            }
                          ],
                        );
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [marker]);
                        }
                      },
                      child: Text("Option 1"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var marker = map.currentState?.SphereObject(
                          "Marker",
                          args: [
                            {
                              "lon": 99.35,
                              "lat": 14.25,
                            },
                            {
                              "title": "Custom Marker",
                              "icon": {
                                "html": "Marker",
                                "offset": {
                                  "x": 18,
                                  "y": 21,
                                }
                              },
                              "popup": {"html": "<div>popup</div>"}
                            }
                          ],
                        );
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [marker]);
                        }
                      },
                      child: Text("Option 2"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var marker = map.currentState?.SphereObject(
                          "Marker",
                          args: [
                            {
                              "lon": 100.41,
                              "lat": 13.84,
                            },
                            {
                              "title": "Rotate Marker",
                              "rotate": 90,
                            }
                          ],
                        );
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [marker]);
                        }
                      },
                      child: Text("Option 3"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var marker = map.currentState?.SphereObject(
                          "Marker",
                          args: [
                            {
                              "type": "Feature",
                              "properties": [],
                              "geometry": {
                                "type": "Point",
                                "coordinates": [
                                  100.49477577209473,
                                  13.752891404314328,
                                ]
                              },
                            }
                          ],
                        );
                        if (marker != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [marker]);
                        }
                      },
                      child: Text("GeoJson"),
                    ),
                  ],
                ),
                Text(
                  "Geometry",
                  style: Theme.of(context).textTheme.headline6,
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        var polyline = map.currentState?.SphereObject(
                          "Polyline",
                          args: [
                            [
                              {
                                "lon": 100,
                                "lat": 14,
                              },
                              {
                                "lon": 101,
                                "lat": 15,
                              },
                              {
                                "lon": 102,
                                "lat": 14,
                              },
                            ],
                            {
                              "title": "Polyline",
                              "detail": "-",
                              "label": "Polyline",
                              "lineWidth": 4,
                              "lineColor": "rgba(255, 0, 0, 0.8)"
                            }
                          ],
                        );
                        if (polyline != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [polyline]);
                        }
                      },
                      child: Text("Polyline"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var dashline = map.currentState?.SphereObject(
                          "Polyline",
                          args: [
                            [
                              {
                                "lon": 99,
                                "lat": 14,
                              },
                              {
                                "lon": 100,
                                "lat": 15,
                              },
                              {
                                "lon": 101,
                                "lat": 14,
                              }
                            ],
                            {
                              "title": "Dashline",
                              "detail": "-",
                              "label": "Dashline",
                              "lineWidth": 4,
                              "lineColor": "rgba(255, 0, 0, 0.8)",
                              "lineStyle": map.currentState?.SphereStatic(
                                "LineStyle",
                                "Dashed",
                              ),
                              "pointer": true
                            }
                          ],
                        );
                        if (dashline != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [dashline]);
                        }
                      },
                      child: Text("Dashline"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var polygon = map.currentState?.SphereObject(
                          "Polygon",
                          args: [
                            [
                              {
                                "lon": 99,
                                "lat": 14,
                              },
                              {
                                "lon": 100,
                                "lat": 13,
                              },
                              {
                                "lon": 102,
                                "lat": 13,
                              },
                              {
                                "lon": 103,
                                "lat": 14,
                              }
                            ],
                            {
                              "title": "Polygon",
                              "detail": "-",
                              "label": "Polygon",
                              "lineWidth": 2,
                              "lineColor": "rgba(0, 0, 0, 1)",
                              "fillColor": "rgba(255, 0, 0, 0.4)",
                              "visibleRange": {
                                "min": 5,
                                "max": 18,
                              },
                              "editable": true,
                              "weight": map.currentState?.SphereStatic(
                                "OverlayWeight",
                                "Top",
                              )
                            }
                          ],
                        );
                        if (polygon != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [polygon]);
                        }
                      },
                      child: Text("Polygon"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var circle = map.currentState?.SphereObject(
                          "Circle",
                          args: [
                            {
                              "lon": 101,
                              "lat": 15,
                            },
                            1,
                            {
                              "title": "Geom 3",
                              "detail": "-",
                              "lineWidth": 2,
                              "lineColor": "rgba(255, 0, 0, 0.8)",
                              "fillColor": "rgba(255, 0, 0, 0.4)",
                            }
                          ],
                        );
                        if (circle != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [circle]);
                        }
                      },
                      child: Text("Circle"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        var dot = map.currentState?.SphereObject(
                          "Dot",
                          args: [
                            {
                              "lon": 100.540574,
                              "lat": 13.714765,
                            },
                            {
                              "lineWidth": 20,
                              "draggable": true,
                            }
                          ],
                        );
                        if (dot != null) {
                          map.currentState?.call("Overlays.add", args: [dot]);
                        }
                      },
                      child: Text("Dot"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var donut = map.currentState?.SphereObject(
                          "Polygon",
                          args: [
                            [
                              {
                                "lon": 101,
                                "lat": 15,
                              },
                              {
                                "lon": 105,
                                "lat": 15,
                              },
                              {
                                "lon": 103,
                                "lat": 12,
                              },
                              null,
                              {
                                "lon": 103,
                                "lat": 14.9,
                              },
                              {
                                "lon": 102.1,
                                "lat": 13.5,
                              },
                              {
                                "lon": 103.9,
                                "lat": 13.5,
                              }
                            ],
                            {
                              "lon": 100.540574,
                              "lat": 13.714765,
                            },
                            {
                              "label": true,
                              "clickable": true,
                            }
                          ],
                        );
                        if (donut != null) {
                          map.currentState?.call("Overlays.add", args: [donut]);
                        }
                      },
                      child: Text("Donut"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () {
                        var rectangle = map.currentState?.SphereObject(
                          "Rectangle",
                          args: [
                            {
                              "lon": 100.617,
                              "lat": 13.896,
                            },
                            {
                              "width": 2,
                              "height": 1,
                            },
                            {
                              "editable": true,
                            }
                          ],
                        );
                        if (rectangle != null) {
                          map.currentState
                              ?.call("Overlays.add", args: [rectangle]);
                        }
                      },
                      child: Text("Rectangle"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        var polygon = map.currentState?.SphereObject(
                          "Polygon",
                          args: [
                            [
                              {
                                "lon": 99,
                                "lat": 14,
                              },
                              {
                                "lon": 100,
                                "lat": 13,
                              },
                              {
                                "lon": 102,
                                "lat": 13,
                              },
                              {
                                "lon": 103,
                                "lat": 14,
                              }
                            ]
                          ],
                        );
                        if (polygon != null) {
                          var result = await map.currentState?.objectCall(
                            polygon,
                            "size",
                          );
                          print(result);
                        }
                      },
                      child: Text("Geometry Area"),
                    ),
                    SizedBox(width: 8),
                    OutlinedButton(
                      onPressed: () async {
                        var polyline = map.currentState?.SphereObject(
                          "Polyline",
                          args: [
                            [
                              {
                                "lon": 100,
                                "lat": 14,
                              },
                              {
                                "lon": 101,
                                "lat": 15,
                              },
                              {
                                "lon": 102,
                                "lat": 14,
                              }
                            ],
                            {
                              "title": "Polyline",
                              "detail": '-',
                              "label": "Polyline",
                              "lineWidth": 4,
                              "lineColor": "rgba(255, 0, 0, 0.8)"
                            }
                          ],
                        );
                        if (polyline != null) {
                          var result = await map.currentState?.objectCall(
                            polyline,
                            "size",
                            args: [
                              "th",
                            ],
                          );
                          print(result);
                        }
                      },
                      child: Text("Format Distance Polyline"),
                    ),
                  ],
                ),
              ],
            ),
          ))
        ],
      )),
    );
  }
}
