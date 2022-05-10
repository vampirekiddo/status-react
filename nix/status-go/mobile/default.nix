{ callPackage
, meta, source
, goBuildFlags
, goBuildLdFlags }:

{
  android = callPackage ./build.nix {
    platform = "android";
    targets = [ "android/arm" "android/arm64" "android/386" ]; # 386 is for android simulator
    outputFileName = "status-go-${source.shortRev}.aar";
    inherit meta source goBuildFlags goBuildLdFlags;
  };

  ios = callPackage ./build.nix {
    platform = "ios";
    targets = [ "ios" "iossimulator" ];
    outputFileName = "Statusgo.xcframework";
    inherit meta source goBuildFlags goBuildLdFlags;
  };
}
