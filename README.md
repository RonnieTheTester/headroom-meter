# headroom-meter

Live terminal meter for Headroom compression.

`headroom-meter` watches `~/.headroom/logs/proxy.log` and turns Headroom's
proxy logs into a live terminal dashboard:

- token savings across completed requests
- latest request savings
- recent-request pulse graph
- frame-compression graph
- cache hit rate
- optimization time
- active transforms
- TOIN pattern/compression activity

This is an unofficial companion tool for Headroom.

## Preview

```text
HEADROOM REGEN DASHBOARD
Status ACTIVE  Last event 3s ago
Log: /Users/you/.headroom/logs/proxy.log
================================================================================

TOKEN REGEN
  ████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  1.90% captured  (full scale: 25%)
  RAW >> REGEN 2,551 tokens >> MODEL

RECENT REQUEST PULSES
  ▁▁▁▁▂▁▁▁▁▁▅▁▁▁▇▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁▁
  last  4.24%  avg  1.90%  peak 40.96%

FRAME COMPRESSION
  █████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  5.69% byte reduction  last frame 13.68%
  ▁▁▁▁▁▁▁▁▁▂▁▁▂▁▁▁▁▃▁▁▁▆▁▁▁▁▁▁▁▂▁▁▇▁▁▁▁

SAVED TOKENS     53,769 total
LAST REQUEST     2,551 saved from 60,229
REQUESTS         66 completed, 814 avg saved
CACHE BATTERY    ███████████████████████░  92.7%
OPTIMIZE TIME    156 ms avg
TRANSFORMS       compaction, mixed, text, smart_crusher, kompress, log
TOIN:         63 patterns, 78 compressions, 0 retrievals (0.0% retrieval rate)
```

## Install

Clone the repo, then run:

```bash
./install.sh
```

The installer copies `bin/headroom-meter` into `~/.local/bin`.

Make sure `~/.local/bin` is on your `PATH`.

## Usage

Start the live meter:

```bash
headroom-meter
```

Start counting from zero instead of aggregating the existing log:

```bash
headroom-meter --live-only
```

Print one snapshot and exit:

```bash
headroom-meter --once
```

Make the visual bar more sensitive:

```bash
headroom-meter --scale 10
```

Force color output, useful when piping through a terminal recorder:

```bash
headroom-meter --color always
```

Use ASCII-only graphs:

```bash
headroom-meter --ascii
```

Use a custom Headroom log path:

```bash
headroom-meter --log /path/to/proxy.log
```

## Requirements

- Python 3.10+
- A Headroom proxy log at `~/.headroom/logs/proxy.log`

No Python packages are required.

## Development

Run a syntax check:

```bash
python3 -m py_compile bin/headroom-meter
```

Run a one-shot local smoke test:

```bash
bin/headroom-meter --once
```

## License

MIT
