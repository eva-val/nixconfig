{ pkgs, ... }:

{
  # Deliberately privileged and opt-in: members of users can run arbitrary
  # Python with CAP_NET_RAW and CAP_NET_ADMIN through /run/wrappers/bin/pynet.
  security.wrappers.pynet = {
    owner = "root";
    group = "users";
    capabilities = "cap_net_raw,cap_net_admin+ep";
    source = "${pkgs.python3}/bin/python3";
  };
}
