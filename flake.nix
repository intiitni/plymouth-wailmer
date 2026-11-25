{
  description = "A Plymouth theme featuring a spinning Wailmer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "plymouth-wailmer-theme";
            version = "1.0.0";

            src = pkgs.lib.cleanSource ./.;

            dontBuild = true;

            installPhase = ''
              runHook preInstall

              mkdir -p $out/share/plymouth/themes/wailmer
              
              # Copy only the contents of the wailmer theme directory
              cp -r wailmer/* $out/share/plymouth/themes/wailmer
              
              # Patch the .plymouth file to use the Nix store path instead of hardcoded /usr/
              find $out/share/plymouth/themes/wailmer -name "*.plymouth" -exec sed -i "s@/usr/@$out/@" {} \;

              runHook postInstall
            '';

            meta = {
              description = "Plymouth theme featuring a spinning Wailmer";
              homepage = "https://github.com/intiitni/plymouth-wailmer";
              # license = pkgs.lib.licenses.mit;
              platforms = systems;
              # maintainers = with pkgs.lib.maintainers; [ "intiitni" ]; 
            };
          };
        }
      );

      # Optional: makes `nix develop` work if you want to hack on the render scripts
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [ python3 ffmpeg parallel optipng ];
          };
        }
      );
    };
}