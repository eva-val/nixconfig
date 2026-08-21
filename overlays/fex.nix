final: prev: {
  # FEX 2605 doesn't build against fmt 12 (`fmt::join` over a span of bytes
  # trips an undefined-template error). Remove once FEX supports fmt 12.
  fex = prev.fex.override { fmt = prev.fmt_11; };
}
