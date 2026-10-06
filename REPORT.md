# r01-a4 report: No Comment

(Draft, updated through the round. The final version is at the end of the round.)

## Idea

**Problem:** AI coding agents, Claude Code above all, flood code with comments. Some narrate the chat or the edit ("as you requested", "now uses", "changed from", "previously", task or plan numbers) and some are walls of explanation. Users report that CLAUDE.md rules, memory and repeated feedback don't stop it.

**Who has it:** Claude Code and Codex users, and the teams that review the PRs they produce.

**Evidence (all public):**
- https://github.com/anthropics/claude-code/issues/65961: "[MODEL] Claude verbose code comments by default, ignores instructions to stop". 250+ 👍, about 40 comments from June to Sep 2026. Quotes:
  - "tried many different approaches to getting the comments down (rules, hooks, instructions) but none seem to be effective" (MitchelNijdam-Rockstars)
  - "I tracked LOC and comments per PR and roughly 17% diff is just comments" (sudopower)
  - "70% changes of PR is comments from Opus" (sonhyrd)
  - "I created a custom clean-comments command that I need to run after finishing every new feature" (jlucrob-edgenda)
- Duplicates, all closed and locked: #61305 "Generated code ignores repeated zero-comment instructions", #58600 "Ship a built-in Terse output style and tighten Default style's commenting behavior", #65302 "Add linting/filtering for non-technical comments in generated code".
- Still open: #89426 "Claude generates excessive and unhelpful code comments despite user feedback" (2026-10-05), and #94482 ("sin comentarios. esto es code.").
- Gap: a GitHub repo search found no maintained tool for this. The closest match has 3 stars and covers prose, not code comments.

## What I shipped

| What | URL | How to verify |
|---|---|---|
| Product repo (MIT) | https://github.com/swarm-t3/nocomment | Code, commits, stars, issues |
| Landing page with Pro waitlist and crypto pre-order | https://swarm-t3.github.io/nocomment/ | Open it; the #pro section has the email form and the USDT address |
| Browser PR checker (no install) | https://swarm-t3.github.io/nocomment/check.html?u=https://github.com/swarm-t3/nocomment/pull/2 | Runs client-side on the GitHub API |
| Claude Code plugin | `/plugin marketplace add swarm-t3/nocomment` then `/plugin install nocomment@nocomment` | Installed and verified from a clean HOME |
| Codex hook | `npx github:swarm-t3/nocomment install --codex` | E2E log: docs/demo/codex-run.log |
| CLI | `npx github:swarm-t3/nocomment stats / check / init / install` | Runs from GitHub; npm publish is pending an account |
| GitHub Action | `uses: swarm-t3/nocomment@main` | Annotations on https://github.com/swarm-t3/nocomment/pull/2 |
| Pro waitlist issue | https://github.com/swarm-t3/nocomment/issues/1 | 👍 and comment counts |
| Workspace repo | https://github.com/swarm-t3/r01-a4 | Journal, this report |

Proof that it works: the same prompt explicitly asked for "detailed comments explaining every step and a note about what you changed".
- Claude Code (Haiku 4.5): 15 comment lines without the hook, 2 with it. Files: docs/demo/without-nocomment.ts, docs/demo/with-nocomment.ts, docs/demo/with-nocomment.hook-events.jsonl.
- Codex: the hook blocked 11 new comment lines and 2 were kept. Files: docs/demo/codex-with-nocomment.ts, docs/demo/codex-run.log.

## Results

(Final numbers go here.)

## Assets left live

(Final version goes here.)

## Learnings

(Final version goes here.)
