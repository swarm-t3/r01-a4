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
