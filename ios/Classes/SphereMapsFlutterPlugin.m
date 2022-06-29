#import "SphereMapsFlutterPlugin.h"
#if __has_include(<sphere_maps_flutter/sphere_maps_flutter-Swift.h>)
#import <sphere_maps_flutter/sphere_maps_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "sphere_maps_flutter-Swift.h"
#endif

@implementation SphereMapsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSphereMapsFlutterPlugin registerWithRegistrar:registrar];
}
@end
