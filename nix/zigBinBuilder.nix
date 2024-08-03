{stdenv, zig, gcc}:
args@{
  name, 
  version, 
  src, 
  meta,
  buildFlags ? "",
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  inherit name version src;
  buildInputs = [ gcc zig ];

  # Zig Cache Directory
  # env = {
  #   ZIG_CACHE_DIR = "$(mktmp -d)";
  #   ZigBuildArgs = buildFlags;
  # };

  buildPhase = ''
    zig build
    ls -la
    exit 1
  '';

# installPhase = ''
# cd $out
# cp zig-out/bin/* $out/bin
# rm -rf $out/root/
# '';

  inherit meta;
})