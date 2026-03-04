let npinsed = import ./npins; in {
  pkgs ? import npinsed.nixpkgs {},
  buildLocalTypstEnv ? pkgs.callPackage npinsed.local-typst-env {},
}: buildLocalTypstEnv {
  src = (import npinsed.gitignore-nix {lib=pkgs.lib;}).gitignoreSource ./.;
  nativeBuildInputs = [
    pkgs.npins
    # use check_regex_order.py from xieby1/nestoc
    (let src = pkgs.fetchurl {
      url = "https://github.com/xieby1/nestoc/raw/b893af13e082caae5073c16605625f4cb86e6634/doc/check_regex_order.py";
      sha256 = "1kf7p3yba100i3ir7zs2cgpivrr2369mkckcpas5n8z64pxgf2jh";
    }; in pkgs.writeScriptBin src.name "${pkgs.python3}/bin/python3 ${src} $@")
    pkgs.poppler-utils
  ];
  buildInputs = [
    pkgs.typst
  ];
}
