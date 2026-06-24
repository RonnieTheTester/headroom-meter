# Technology Notes

`headroom-meter` is an observability layer. It does not compress prompts itself;
it reads Headroom's proxy log and turns compression events into a live terminal
dashboard.

## What The Meter Reads

Headroom writes completed request lines with fields like:

```text
tok_before=60229 tok_after=57678 tok_saved=2551 cache_hit_pct=98
```

The meter interprets those fields as:

- `tok_before`: input-token estimate before Headroom transformations
- `tok_after`: input-token estimate after transformations
- `tok_saved`: request-level token reduction
- `cache_hit_pct`: how much of the context was served from cached state
- `opt_ms`: time spent optimizing/compressing before the upstream request

It also parses WebSocket frame compression lines:

```text
frame compressed 48145->42353 bytes (1279 tokens saved, auth_mode=oauth, frame=63)
```

Those lines drive the frame-compression graph.

## Speedometer vs Odometer

The speedometer is intentionally a current reading. It uses the latest completed
request:

```text
latest savings % = tok_saved / tok_before
```

That makes sudden strong or weak compression visible immediately.

The odometer is cumulative:

```text
odometer = sum(tok_saved)
```

The two numbers answer different questions:

- **Speedometer:** how much did Headroom save right now?
- **Odometer:** how much has Headroom saved over this session/log?

The same glossary is available in the terminal:

```bash
headroom-meter /help
```

`/help` does not start live mode. It prints the dashboard label explanations and
exits.

## Example Field Reading

One local Codex + Headroom session produced this reading on June 24, 2026:

```text
requests:              196
tokens before:         14,180,388
tokens after:          13,845,926
tokens saved:          334,462
average saved/request: 1,706
peak saved/request:    65,187
average cache hit:     95.2%
frame tokens saved:    154,575
frame byte reduction:  6.07%
```

This is intentionally presented as a field reading, not a benchmark. It is useful
because it shows the sort of operational signal the dashboard exposes in real
use.

## Why Compression Matters

Long-context agents accumulate command output, source files, tool schemas, logs,
and conversation state. That context has operational cost:

- more input tokens to process
- more memory pressure
- more latency exposure
- more chance that important information is buried in the middle of the prompt

Prompt and context compression are active research areas because they attack
that cost before a request reaches the model.

## Relevant Research

- [Selective Context](https://arxiv.org/abs/2310.06201) identifies and prunes
  redundant context. The paper reports a 50% context-cost reduction with lower
  memory use and inference time on its evaluated tasks.
- [LLMLingua](https://arxiv.org/abs/2310.05736) uses a coarse-to-fine prompt
  compression method with budget control and token-level compression.
- [LLMLingua-2](https://arxiv.org/abs/2403.12968) treats prompt compression as
  a faithful token-classification problem and reports faster compression with
  lower end-to-end latency in its experiments.
- [Prompt Compression for Large Language Models: A Survey](https://arxiv.org/abs/2410.12388)
  categorizes prompt compression into hard and soft approaches and summarizes
  the field.
- [Lost in the Middle](https://arxiv.org/abs/2307.03172) shows that long-context
  models do not always use the middle of long inputs robustly. Compression is not
  a cure-all, but it is part of disciplined context management.

## What This Project Adds

Most compression tools expose numbers after the fact, if at all. `headroom-meter`
is designed for live operational feedback:

- Are tokens being saved right now?
- Did the last request compress well?
- Did cache reuse stay healthy?
- Did WebSocket frame compression kick in?
- Which Headroom transforms were active?

The goal is not to replace logs. The goal is to make the logs obvious enough
that humans can react while the agent is still running.
