final: prev: {
  cook-cli = prev.cook-cli.overrideAttrs (
    old:
    # We want to be notified when cook-cli is updated in nixpkgs.
    assert old.version == "0.7.1";
    rec {
      version = "0.10.0";
      src = prev.fetchFromGitHub {
        owner = "cooklang";
        repo = "cookcli";
        rev = "v${version}";
        hash = "sha256-1m2+etJG+33fPTxBF8qT/U9WiZGcSn9r0WlK5PDL6/Q=";
      };

      # From https://nixos.wiki/wiki/Overlays#Rust_packages: "Due to
      # https://github.com/NixOS/nixpkgs/issues/107070 it is not possible to just
      # override cargoHash, instead cargoDeps has to be overriden"
      cargoDeps = old.cargoDeps.overrideAttrs (
        prev.lib.const {
          name = "cook-cli-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-iQqzBoWte8vtb1GVzdczXYXLrBh1sZHLCZTuaUaTie0=";
        }
      );
    }
  );
}
