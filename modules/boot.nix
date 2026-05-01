{ ... }:

{
  # Systemd-boot EFI boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = false;

  # Apple keyboard tweaks
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';
  boot.kernelParams = [ "hid_apple.swap_fn_leftctrl=1" ];

  # Asahi kernel uses 16K pages (CONFIG_ARCH_MMAP_RND_BITS_MAX=31), but
  # nixpkgs can't introspect the Asahi kernel config and defaults to 33,
  # which the kernel rejects. Pin to 31.
  boot.kernel.sysctl."vm.mmap_rnd_bits" = 31;

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
