{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "jackaudio"
      "video"
      "input"
      "kvm"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keyFiles = [
      (builtins.fetchurl "https://github.com/eva-val.keys")
    ];
  };
}
