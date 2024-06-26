{
  description = "3D Seismic Wave Propogation Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    custom-nixpkgs.url = "github:Open-Systems-Innovation/custom-nixpkgs";
  };

  outputs = { self, nixpkgs, custom-nixpkgs, ... }:
      let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ custom-nixpkgs.overlays.default ];
        };
      in
        {
          devShells.${system}.default = pkgs.mkShell {
            name = "default";
               
            packages = [
            # General packages
              # pkgs.hello-nix
               pkgs.petsc
               pkgs.mpich
              # pkgs.bear
              # pkgs.pkg-config-unwrapped
              #  # Python packages
              #(pkgs.python3.withPackages (python-pkgs: [
              #  # packages for formatting/ IDE
              #  python-pkgs.pip
              #  python-pkgs.python-lsp-server
              #  # packages for code
              #  python-pkgs.gmsh
              #  python-pkgs.matplotlib
              #  python-pkgs.meshio
              #  python-pkgs.numpy
              #  python-pkgs.firedrake
              #]))
            ];

            PETSC_DIR = "${pkgs.petsc}";

            shellHook = ''
              if [ ! -f "TAGS" ]; then
                  find $PETSC_DIR/src -name '*.c' | etags -
              fi
              export ENVIRONMENT_NAME="Custom Environment"
              export PS1="┌─[\[\e[01;32m\]\u\[\e[00m\]@\[\e[01;32m\]\h\[\e[00m\]:\[\e[1;34m\]\w\[\e[0m\]][$ENVIRONMENT_NAME]\n└─╼"
            '';
          };
        };
}
