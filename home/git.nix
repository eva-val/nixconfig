{ ... }:

{
  programs.git = {
    enable = true;
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    settings = {
      user = {
        name = "Eva Valentine";
        email = "stephanie.howanietz@pm.me";
      };
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
  };
}
