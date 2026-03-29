{ ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      format = "$directory$git_branch$git_status$nix_shell$python$rust$java$cmd_duration$line_break$character";

      directory.truncation_length = 3;

      nix_shell.symbol = " ";
    };
  };
}
