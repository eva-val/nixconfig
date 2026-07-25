_:

{
  imports = [
    ../../profiles/home/common.nix
    ../../profiles/home/development.nix
    ../../profiles/home/linux-desktop.nix
    ../../profiles/home/cosmic.nix
  ];

  home.stateVersion = "25.11";

  # Native Wayland rendering plus nixbook's 2x panel scale.
  home.sessionVariables._JAVA_OPTIONS = "-Dawt.toolkit.name=WLToolkit -Dsun.java2d.uiScale=2.0";
}
