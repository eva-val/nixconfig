# nixconfig

Flake-based NixOS and Home Manager configuration. The current machine is
`nixbook`, an Apple Silicon Mac running Asahi Linux and COSMIC. The repository
is organized so additional NixOS hosts can share profiles without inheriting
nixbook-specific hardware or applications.

## Repository layout

- `flake.nix` defines inputs, public modules, overlays, packages, checks, and
  host outputs.
- `lib/hosts.nix` constructs NixOS hosts and provides a lazy nix-darwin
  constructor for a future Mac.
- `hosts/<name>/` contains a host's composition, Home Manager composition, and
  generated hardware configuration.
- `profiles/` combines small modules into reusable system or user roles.
- `modules/` contains focused NixOS and Home Manager configuration fragments.
- `packages/` contains custom derivations; `overlays/` exposes them and keeps
  temporary upstream fixes isolated.
- `themes/` contains source-controlled Stylix, Helix, and COSMIC theme assets.
- `users/` contains non-secret user identity data such as public SSH keys.

Host identity travels through `hostSpec`, which currently contains the system,
hostname, username, and home directory. Hardware configuration and state
versions stay with each host.

## Validate and deploy

Run these from the repository root:

```bash
# Format every Nix file.
nix fmt

# Evaluate every flake output and run the formatter/linter checks without
# building the complete system closure.
nix flake check --no-build --impure

# Build nixbook without changing the running system.
nix build --no-link --impure \
  .#nixosConfigurations.nixbook.config.system.build.toplevel

# Run every flake check, including the complete nixbook build.
nix flake check --impure

# Activate only after reviewing the build.
sudo nixos-rebuild test --flake /home/eva/nixconfig#nixbook --impure
sudo nixos-rebuild switch --flake /home/eva/nixconfig#nixbook --impure
```

The Apple Silicon support module imports host firmware from `/boot/vendorfw`,
so nixbook evaluation requires `--impure`. Builds from machines without that
firmware should target independent packages or checks rather than the nixbook
system closure.

The repository's pre-commit hook formats staged Nix files. Enable it with:

```bash
git config core.hooksPath .githooks
```

## Composition model

The reusable NixOS baseline is `profiles/nixos/base.nix`; the COSMIC role is
`profiles/nixos/cosmic-workstation.nix`. Home Manager follows the same pattern
with common, development, Linux desktop, and COSMIC profiles. The nixbook files
select those roles and explicitly opt into machine-specific features.

Specialized NixOS modules include:

- Asahi boot and power policy
- CAN-FD bench setup
- automatic brightness through wluma
- FEX/muvm support for x86_64 Linux software
- Android Studio, Bambu Studio, Steam, and Steam battery support
- the `pynet` capability wrapper

Keep these imports host-local unless another machine genuinely needs the same
hardware or security policy. In particular, `pynet` lets members of the
`users` group run Python with `CAP_NET_RAW` and `CAP_NET_ADMIN`; treat enabling
it as an explicit trust decision.

The firewall is enabled. OpenSSH and Tailscale open their own required ports;
new listening services must declare their firewall policy explicitly.

## Add another host

1. Create `hosts/<name>/default.nix`, `home.nix`, and the host's generated
   hardware configuration.
2. Define its `hostSpec` in `flake.nix`.
3. Call `lib.mkNixosHost` with the host module and Home Manager module lists.
4. Start with shared profiles, then add only the feature modules that match the
   machine.
5. Give both NixOS and Home Manager explicit state versions; never update them
   as part of a routine package upgrade.

For a future macOS host, add a pinned `nix-darwin` input and pass it to
`lib.mkDarwinHost`. The constructor is intentionally lazy so this repository
does not carry an unused input today. Reuse OS-neutral Home Manager profiles,
and add Darwin-specific profiles instead of importing Linux desktop modules.

## Maintenance notes

Update ordinary inputs with `nix flake update`, review the lock-file diff, and
run the full checks above. Several local packages and overlays need deliberate
upstream review:

- Android Studio, Bambu Studio, and the FEX root filesystem have pinned URLs,
  versions, and hashes in `packages/`.
- `sommelier-fixed` can disappear once nixpkgs contains the referenced dmabuf
  fix.
- the FEX overlay can disappear once FEX declares its Python `packaging`
  build dependency upstream.
- the wluma overlay can disappear once nixpkgs installs its udev rule.

Comments beside each workaround record its removal condition. Prefer removing
a workaround over carrying it forward after upstream catches up.
