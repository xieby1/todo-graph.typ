let npinsed = import ./npins; in {
  pkgs ? import npinsed.nixpkgs {},
  buildLocalTypstEnv ? pkgs.callPackage npinsed.local-typst-env {},
}: buildLocalTypstEnv {
  src = pkgs.lib.cleanSource ./.;
  nativeBuildInputs = [
    pkgs.npins
  ];
  buildInputs = [
    pkgs.typst
  ];
}
