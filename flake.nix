{
  description = "A simple script";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: {
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.my-script;

    packages.x86_64-linux.my-script =
      let
        pkgs = import nixpkgs { system = "x86_64-linux"; };
      in
      pkgs.writeShellScriptBin "my-script" ''
        DATE="$(${pkgs.ddate}/bin/ddate +'the %e of %B%, %Y')"
        ${pkgs.cowsay}/bin/cowsay Hello, world! Today is $DATE.
      '';
  };
}
