# nvim

Neovim config:

- **dev** — Full setup.
- **default** — For use in restricted env where plugins may be unavailable.

## Profiles

1. `NVIM_PROFILE` env var (`dev`) | one-off override: `NVIM_PROFILE=work nvim`.
3. Default: `` (empty env var).

## Setup

Add environment variable to your shell's profile:

```shell
export NVIM_PROFILE=dev
```

Note: Requires neovim >= 0.12 (uses native `vim.pack`).
