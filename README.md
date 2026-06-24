# headroom-meter

Live terminal meter for Headroom compression.

`headroom-meter` watches `~/.headroom/logs/proxy.log` and turns Headroom's
proxy logs into a compact live dashboard:

- token savings across completed requests
- latest request savings
- frame compression
- cache hit rate
- optimization time
- active transforms
- TOIN pattern/compression activity

This is an unofficial companion tool for Headroom.

## Preview

```text
Headroom Live Meter
Status: active  Last event: 3s ago
Log: /Users/you/.headroom/logs/proxy.log

Token savings  [###-------------------------------]  1.90% (scale full = 25%)
Saved tokens:  53,769 / 2,827,682 input tokens across 66 requests
Last request:  2,551 tokens saved from 60,229 (4.24%)

Frame bytes    [########--------------------------]  5.69%
Frame events:  64 frames, 53,462 frame tokens saved

Cache hit avg:  92.7%   Avg optimize: 156 ms
Transforms:   compaction, mixed, text, smart_crusher, kompress, log
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
