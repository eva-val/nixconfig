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
  };
}
