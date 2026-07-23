{ ... }:

{
  # Apple Silicon / Asahi support (explicit to avoid the deprecated implicit default)
  hardware.asahi.enable = true;

  # Systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = false;

  # Apple keyboard tweaks
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = [
    "hid_apple.swap_fn_leftctrl=1"
    "appledrm.show_notch=1"
  ];

  # Asahi kernel uses 16K pages (CONFIG_ARCH_MMAP_RND_BITS_MAX=31), but
  # nixpkgs can't introspect the Asahi kernel config and defaults to 33,
  # which the kernel rejects. Pin to 31.
  boot.kernel.sysctl."vm.mmap_rnd_bits" = 31;

  # Battery: powertop-flagged tunables. Disable the NMI watchdog (a per-CPU
  # timer we don't need on a laptop) and batch dirty-page writeback so the
  # disk wakes less often when idle.
  boot.kernel.sysctl."kernel.nmi_watchdog" = 0;
  boot.kernel.sysctl."vm.dirty_writeback_centisecs" = 1500;

  # Disable sleep key (F6/moon)
  services.logind.settings.Login.HandleSuspendKey = "ignore";

  # Swap
  zramSwap.enable = true;

  # Locale & console
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}
