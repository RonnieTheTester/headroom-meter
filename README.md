<p align="center">
  <img src="assets/demo.svg" alt="headroom-meter terminal dashboard preview" width="900">
</p>

<h1 align="center">headroom-meter</h1>

<p align="center">
  <strong>Watch Headroom compression happen live.</strong><br>
  A sleek terminal dashboard that makes token savings feel as tangible as regenerative braking.
</p>

<p align="center">
  <a href="https://github.com/RonnieTheTester/headroom-meter/actions/workflows/ci.yml"><img alt="CI" src="https://github.com/RonnieTheTester/headroom-meter/actions/workflows/ci.yml/badge.svg"></a>
  <img alt="Python 3.10+" src="https://img.shields.io/badge/python-3.10%2B-3776AB?logo=python&logoColor=white">
  <img alt="No dependencies" src="https://img.shields.io/badge/dependencies-none-00D084">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
</p>

---

## Why This Exists

Headroom can save a lot of context, but raw proxy logs do not make that obvious.
`headroom-meter` turns those invisible savings into a live dashboard:

- a token regen gauge that fills as Headroom compresses
- recent request pulses so spikes are visible immediately
- frame-compression bars for websocket traffic
- a cache battery, optimization timing, and active transform list
- no dependencies, no daemon, no telemetry

If Headroom is doing work, this makes the work visible.

## Install

Fast install from GitHub:

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/RonnieTheTester/headroom-meter/main/bin/headroom-meter -o ~/.local/bin/headroom-meter
chmod +x ~/.local/bin/headroom-meter
```

Or clone it:

```bash
git clone https://github.com/RonnieTheTester/headroom-meter.git
cd headroom-meter
./install.sh
```

Make sure `~/.local/bin` is on your `PATH`.

## Usage

Start the live dashboard:

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

Make the bars more sensitive:

```bash
headroom-meter --scale 10
```

Force color output, useful for terminal recordings:

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

Check the installed version:

```bash
headroom-meter --version
```

## What It Reads

By default, `headroom-meter` tails:

```text
~/.headroom/logs/proxy.log
```

It parses Headroom log fields such as:

```text
tok_before=60229 tok_after=57678 tok_saved=2551 cache_hit_pct=98
```

The script is read-only. It does not modify Headroom config or send data anywhere.

## Requirements

- Python 3.10+
- A running Headroom proxy writing `~/.headroom/logs/proxy.log`
- A terminal that supports ANSI escape codes

No Python packages are required.

## Development

Run checks:

```bash
python3 -m py_compile bin/headroom-meter
bin/headroom-meter --once --color never --ascii
```

Run the local installer:

```bash
./install.sh
```

## Roadmap

- compact mode for narrow terminals
- optional exportable session summary
- better synthetic fixture tests
- terminal recording for the README

## Star It

If this makes Headroom feel easier to understand, star the repo so other Codex
and Headroom users can find it.

## License

MIT
