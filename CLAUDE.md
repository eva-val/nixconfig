# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

NixOS configuration for an Apple Silicon Mac (aarch64-linux) running Asahi Linux via nixos-apple-silicon. Flakes-based, single-host setup named `nixbook`.

## Build & Deploy

```bash
# Rebuild and switch (aliased as `rebuild` in Fish shell)
sudo nixos-rebuild switch --flake /home/eva/nixconfig#nixbook --impure
```

The `--impure` flag is required due to the Apple Silicon support module.

## Architecture

- **flake.nix** — Entry point. Defines inputs, passes `specialArgs` (hostname, username), composes the module list
- **hosts/nixbook.nix** — Host-specific glue: imports hardware-configuration + all modules, sets hostname and stateVersion
- **hardware-configuration.nix** — Auto-generated hardware config (do not edit)
- **modules/boot.nix** — Boot loader, Apple keyboard kernel tweaks, zramSwap, locale, console
- **modules/networking.nix** — NetworkManager, OpenSSH, Tailscale, systemd-resolved, automatic-timezoned
- **modules/desktop.nix** — COSMIC greeter+desktop, fonts, XKB layout, libinput, printing, thumbnails
- **modules/programs.nix** — System packages, Firefox, Git (SSH signing), Fish (aliases), Starship, GnuPG, Nix daemon settings
- **modules/user.nix** — User account (eva), user packages, shell assignment

All modules are plain NixOS configuration fragments (no custom options/mkOption). `specialArgs` passes `hostname` and `username` from the flake to avoid hardcoding.

## Key Details

- **Platform**: aarch64-linux (Apple Silicon / Asahi)
- **Desktop**: COSMIC
- **Shell**: Fish with Starship prompt
- **User**: eva
- **Binary cache**: nixos-apple-silicon.cachix.org (configured as substituter)
- **Nix features**: flakes, nix-command, auto-optimise-store, weekly GC (30-day keep)
