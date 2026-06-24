# Contributing

Thanks for helping improve `headroom-meter`.

This project should stay:

- dependency-free
- fast to install
- readable in one script
- useful in real terminals, not only screenshots

## Local Checks

```bash
python3 -m py_compile bin/headroom-meter
bin/headroom-meter --once --color never --ascii
```

If you change the dashboard layout, test it in a narrow and a wide terminal.

## Good First Improvements

- better compact mode for narrow terminals
- more robust fixtures for unusual Headroom log lines
- optional summary export
- a real terminal recording for the README

## Pull Requests

Keep PRs focused. A visual polish PR should not also rewrite parsing behavior.
