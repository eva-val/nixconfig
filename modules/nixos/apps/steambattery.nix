{ inputs, ... }:

{
  imports = [ inputs.steambattery.nixosModules.default ];
  hardware.steambattery.enable = true;
}
