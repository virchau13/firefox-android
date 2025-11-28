{ pkgs ? import <nixpkgs> {config.android_sdk.accept_license = true; config.allowUnfree = true;} }:

let
  androidSdkArgs = {
    toolsVersion = "26.1.1";
    platformToolsVersion = "33.0.3";
    buildToolsVersions = [ "30.0.3" ];
    includeEmulator = true;
    emulatorVersion = "33.1.6";
    platformVersions = [ "33" ];
    includeSources = false;
    includeSystemImages = true;
    systemImageTypes = [ "google_apis_playstore" ];
    abiVersions = [ "x86_64" "arm64-v8a" ];
    cmakeVersions = [ "3.10.2" ];
    includeNDK = false;
    # ndkVersions = ["22.1.7171670" "21.4.7075529"];
    useGoogleAPIs = false;
    useGoogleTVAddOns = false;
    includeExtras = [
      "extras;google;gcm"
    ];
  };
  androidSdk = (pkgs.androidenv.composeAndroidPackages androidSdkArgs).androidsdk;

  androidEmulator = pkgs.androidenv.emulateApp {
    name = "emulate-android-nix";
    platformVersion = builtins.elemAt androidSdkArgs.platformVersions 0;
    abiVersion = "x86";
    systemImageType = "google_apis_playstore";
    sdkExtraArgs = androidSdkArgs;
  };
in
(pkgs.buildFHSUserEnv {
  name = "android-fenix-env";
  targetPkgs = pkgs: (with pkgs; [
    androidSdk
    glibc
    gcc
    vulkan-loader
    vulkan-tools
    libGL
  ]);
  runScript = pkgs.writeShellScript "android-fenix-env-init" ''
    export ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk"
    export CC=gcc
    #export PATH=${androidEmulator}/bin:"$PATH"
    exec bash
  '';
}).env
# pkgs.mkShell {
#   buildInputs = with pkgs; [
#     androidSdk
#     glibc
#   ];
#   # override the aapt2 that gradle uses with the nix-shipped version
#   # writeShellScriptBin is required here cuz its stupid
#   # GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${pkgs.writeShellScriptBin "aapt2" ''
#   #   opts=()
#   #   while [ "$#" -gt 0 ]; do
#   #     if [[ "$1" == "--source-path" ]]; then
#   #       shift # ignore next
#   #       shift
#   #     fi
#   #     opts+=("$1")
#   #   done
#   #   exec ${androidSdk}/libexec/android-sdk/build-tools/30.0.2/aapt2 "''${opts[@]}"
#   # ''}/bin/aapt2";
#   GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/33.0.2/aapt2";
#   ANDROID_SDK_ROOT="${androidSdk}/libexec/android-sdk";
# }
