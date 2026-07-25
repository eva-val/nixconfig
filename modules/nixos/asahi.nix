_:

{
  hardware.asahi.enable = true;

  nix.settings = {
    # Fanless laptop: avoid sustained thermal throttling.
    max-jobs = 2;
    cores = 2;
    extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
    extra-trusted-public-keys = [
      "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
    ];
  };

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = false;
    };

    extraModprobeConfig = ''
      options hid_apple iso_layout=0
    '';
    kernelParams = [
      "hid_apple.swap_fn_leftctrl=1"
      "appledrm.show_notch=1"
    ];

    kernel.sysctl = {
      # The Asahi kernel uses 16K pages and rejects nixpkgs' default of 33.
      "vm.mmap_rnd_bits" = 31;
      "kernel.nmi_watchdog" = 0;
      "vm.dirty_writeback_centisecs" = 1500;
    };
  };

  services.logind.settings.Login.HandleSuspendKey = "ignore";
  zramSwap.enable = true;

}
