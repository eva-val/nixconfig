{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "video"
      "input"
      "kvm"
      "audio"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keyFiles = [
      (pkgs.fetchurl {
        url = "https://github.com/eva-val.keys";
        hash = "sha256-PZ/8gubiKHLGSefWDy/DZACSu52npx+a1TLWUdFKZ+0=";
      })
    ];
  };
}
