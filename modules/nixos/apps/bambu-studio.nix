{ pkgs, ... }:

{
  imports = [ ../fex.nix ];
  environment.systemPackages = [ pkgs.muvm-bambu-studio ];
}
