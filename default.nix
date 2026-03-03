let npinsed = import ./npins; in {
  pkgs ? import npinsed.nixpkgs {},
  buildLocalTypstEnv ? pkgs.callPackage npinsed.local-typst-env {},
}: buildLocalTypstEnv {
  src = pkgs.lib.cleanSource ./.;
  nativeBuildInputs = [
    pkgs.npins
    # use check_regex_order.py from xieby1/nestoc
    (let src = pkgs.fetchurl {
      url = "https://github.com/xieby1/nestoc/raw/afbd6a39c46b2ab26c808ce34b3bb8ce80941442/doc/check_regex_order.py";
      sha256 = "0gxyj3di9n1w5hd7pr07ad6dxn3xn6q46bi3imv84isvsvbbhpci";
    }; in pkgs.writeScriptBin src.name "${pkgs.python3}/bin/python3 ${src} $@")
    pkgs.poppler-utils
  ];
  buildInputs = [
    pkgs.typst
  ];
}
