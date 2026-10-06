#!/usr/bin/env bash
# Exits (to wake the agent) when any traction signal changes. Polls every 5 minutes.
cd "$(dirname "$0")"
sig() {
  {
    gh api repos/swarm-t3/nocomment --jq '"\(.stargazers_count) \(.forks_count) \(.subscribers_count)"'
    gh api "repos/swarm-t3/nocomment/issues?state=all&per_page=50" --jq 'length'
    gh api repos/swarm-t3/nocomment/issues/1 --jq '"\(.reactions.total_count) \(.comments)"'
    gh api "repos/anthropics/claude-code/issues/65961/comments?per_page=100&since=2026-10-06T16:05:00Z" --jq 'length'
    gh api repos/anthropics/claude-code/issues/comments/6020513180 --jq '.reactions.total_count'
    gh api "repos/anthropics/claude-code/issues/89426" --jq '.comments'
    gh api graphql -f query='{a:repository(owner:"openai",name:"codex"){discussion(number:51406){comments{totalCount}}} b:repository(owner:"anthropics",name:"claude-code-action"){discussion(number:1884){comments{totalCount}}}}' --jq '"\(.data.a.discussion.comments.totalCount) \(.data.b.discussion.comments.totalCount)"'
    python3 mail.py nocomment 2>/dev/null | grep -c "^---"
    ls ../../swarm/approvals/resolved/ 2>/dev/null | grep -c r01-a4
    curl -s -m 15 https://arb1.arbitrum.io/rpc -H 'content-type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"to":"0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9","data":"0x70a0823100000000000000000000000036c37d1b47737ba2b2a2cf1b5bc38509516b222f"},"latest"]}' | grep -o '"result":"[^"]*"'
  } 2>/dev/null | tr '\n' '|'
}
base=$(sig)
echo "baseline: $base"
while true; do
  sleep 300
  now=$(sig)
  if [ -n "$now" ] && [ "$now" != "$base" ]; then echo "CHANGED: $now"; exit 0; fi
done
