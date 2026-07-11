{ pkgs, ... }: {
  security.wrappers.pynet = {
    owner = "root";
    group = "users";
    capabilities = "cap_net_raw,cap_net_admin+ep";
    source = "${pkgs.python3}/bin/python3";
  };
}
