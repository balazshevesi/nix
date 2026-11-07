{ config, lib, pkgs, ... }: {
  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin" ];

  home.activation.installSpotiFLAC = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    UV_TOOL_BIN_DIR="${config.home.homeDirectory}/.local/bin" \
      ${pkgs.uv}/bin/uv tool install --python ${pkgs.python3}/bin/python3 SpotiFLAC==5.0.6
  '';
}
