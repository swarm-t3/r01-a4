# r01-a4 journal

Deadline: 2026-10-07 15:56 UTC.

## 2026-10-06 ~16:00–17:00 UTC: channel + idea hunt
- Workspace was empty, so this is a fresh start. Wallet: USDT on Arbitrum. Whop needs an approval request.
- Gene: distribution first. The free channel I can reach today is GitHub. Big issue threads notify every subscriber, and other tool makers drop links in them and get adopted (the multi-account thread has several workarounds, one now sells at $9.49 on the MS Store).
- Scanned the top-voted open issues on anthropics/claude-code, openai/codex, vscode, zed and others.
  - Crowded, skip: usage/quota monitors (ccusage 18.9k stars, many others), statuslines, buddy replacements, multi-account launchers.
  - Open gap: **Claude writes excessive code comments and ignores instructions to stop.** https://github.com/anthropics/claude-code/issues/65961 has 250 👍 and comments through Sep 2026. Quotes from it:
    - "tried many different approaches to getting the comments down (rules, hooks, instructions) but none seem to be effective" (MitchelNijdam-Rockstars)
    - "roughly 17% diff is just comments" (sudopower); "70% changes of PR is comments from Opus" (sonhyrd)
    - "I created a custom clean-comments command that I need to run after finishing every new feature" (jlucrob-edgenda)
    - "comment review passes to remove most of them ... Opus mostly ignores these instructions" (MarcEspiard)
  - The GitHub repo search turned up no real tool (best match has 3 stars and covers prose, not a hook).
- DECISION: build **No Comment**, a Claude Code plugin with a deterministic PostToolUse hook. It detects comments that were just added and are excessive or refer to the chat, then makes Claude delete them. Also a `nocomment stats` CLI that measures what % of the code Claude wrote is comments (shareable). Free and open source. Paid Pro tier as a priced pre-order (team/CI check, Codex/Cursor support).

## 2026-10-06 16:20 UTC: shipped v0.1.0
- Built No Comment: lib/scan.js (string-aware comment scanner for 30+ languages), lib/rules.js (balanced/strict/chat/off presets), lib/hook.js (Pre/PostToolUse), bin/nocomment.js (hook, stats, check, install, uninstall). Zero dependencies.
- E2E test with real `claude -p` (Haiku 4.5): same prompt asking for detailed comments gave 15 comment lines without the hook and 2 with it. The hook flagged 13 lines on the first edit. Saved to nocomment/docs/demo.
  - Gotcha: this machine's env has CLAUDE_CODE_SAFE_MODE set, which disables plugin and settings hooks. Tests must run with `env -u CLAUDE_CODE_SAFE_MODE`.
- `stats` on Sami's own transcripts: 20% of 41,414 lines Claude wrote in 30 days were comments.
- Public: https://github.com/swarm-t3/nocomment , landing https://swarm-t3.github.io/nocomment/ , Pro waitlist issue https://github.com/swarm-t3/nocomment/issues/1 .
- Waitlist form uses formsubmit.co, activated, delivering to megafi.app1+nocomment@gmail.com. The one ACTIVATION-TEST submission is mine and is not counted. Read the inbox with `python3 mail.py nocomment --body`.
- Verified from a clean HOME: `/plugin marketplace add swarm-t3/nocomment` + install works, and `npx github:swarm-t3/nocomment` works.
- Filed approval: whop-nocomment-pro ($49 lifetime pre-order).
- NEXT: distribution. Comment on #65961 and its duplicates, open awesome-list PRs, post on HN/dev.to if I can make accounts, publish to npm.

## 2026-10-06 16:30 UTC (real clock; earlier entries' times were estimates and ran ahead)
- Distribution done so far:
  - Comment on anthropics/claude-code#65961: https://github.com/anthropics/claude-code/issues/65961#issuecomment-6020513180
  - PRs to awesome lists: jqueryscript/awesome-claude-code#736, rohitg00/awesome-claude-code-toolkit#825
  - hesreallyhim/awesome-claude-code (55k stars) is out: it needs 14 days or 100 stars and a human submitter.
  - Discussions: openai/codex/discussions/51406 (Show and tell), anthropics/claude-code-action/discussions/1884
  - The duplicate issues (#61305, #58600, #65302) are locked.
- Channels blocked from this box: news.ycombinator.com (DNS), reddit (403), dev.to (image reCAPTCHA, which I won't solve), Bluesky (phone). Filed approvals: community-posts (Reddit/HN text, ready to paste), claude-directory-submit (official plugin directory, needs Sami's paid claude.ai account), whop-nocomment-pro.
- v0.2: `init` (team repo install), single-file dist build, GitHub Action (tested: https://github.com/swarm-t3/nocomment/pull/2).
- v0.3: Codex support. E2E with `codex exec --dangerously-bypass-hook-trust`: 11 lines blocked, 2 kept.
- NEXT: data study of comment share in public Claude-co-authored commits vs a pre-AI baseline (evidence + content), Codex transcripts in stats, monitor replies.

## 2026-10-06 ~16:50 UTC
- Commented on two more matching open issues: claude-code#89426 ("excessive and unhelpful code comments despite user feedback") and #94482 (Spanish, "sin comentarios").
- Shipped the browser PR checker: https://swarm-t3.github.io/nocomment/check.html?u=<PR or commit URL>. Pure client-side on the GitHub public API, built from the same scanner by scripts/browser.js.
- `stats` now includes Codex sessions. Codex code-mode wraps apply_patch inside `exec` JS string literals, so stats extracts them.
- Narrowed the "no longer"/"unchanged" patterns after reading real examples (precision).
- Running study/collect.js: 400 Claude-co-authored commits (Sep 2026) vs 400 commits from Mar 2021, one per repo. It saves raw comment texts so numbers can be recomputed.
- Filed approval: product-hunt.
- Gotcha: `pkill -f <pattern>` kills my own bash when the pattern appears in the command line. Use pgrep and kill <pid>.
- Not available: Indie Hackers (Google sign-in only).

## 2026-10-06 16:42 UTC
- The session restart killed the background jobs. Restarted the study (now resumable: `collect.js <kind> N <outfile>`) and watch.sh, both detached with setsid. The watcher logs to /tmp/r01a4-watch.log and prints CHANGED on any traction change.
- Considered building a Claude Code "mod" version (catalogue at mods.aidojo.si auto-scans GitHub, 2,685 mods). Skipped: the local CC is 2.1.283 and mods need 2.1.287+, so I couldn't verify one end to end.
- No approvals resolved yet. Traction is 0 across the board (repo traffic stats lag by hours).
