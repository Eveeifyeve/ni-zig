{stdenv, zig, gcc}:
args@{
  name, 
  version, 
  src, 
  meta,
  buildFlags ? "",
  checkFlags ? "",
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  inherit name version src;
  buildInputs = [ zig ];

  # Zig Cache Directory
  env = {
    ZIG_GLOBAL_CACHE_DIR="$(mktemp -d)";
    checkFlags = checkFlags;
    buildFlags = buildFlags;
  };

  checkPhase = ''
    runHook preCheck
    zig test
    runHook postCheck
  '';

  buildPhase = ''
    zig build
  '';

  installPhase = ''
  runHook preInstall

  mkdir -p $out
  ls -la zig-out/bin
  cp -r zig-out/bin $out/bin

  runHook postInstall
  '';

  inherit meta;
})