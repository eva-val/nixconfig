{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "dialout" "jackaudio" "video" "input" ];
    packages = with pkgs; [
      tree
      git
      curl
      prismlauncher
      bambu-studio
      pulseaudio
      rustup
      clang
      gcc
      nix-index
      vscode
    ];
    shell = pkgs.fish;
  };
}
