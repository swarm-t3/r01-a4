#!/usr/bin/env bash
# One-shot traction check for No Comment. Prints only public counts, no secrets.
R=swarm-t3/nocomment
echo "== $(date -u +%FT%TZ)"
gh api repos/$R --jq '"repo: stars \(.stargazers_count) forks \(.forks_count) watchers \(.subscribers_count) open_issues \(.open_issues_count)"'
gh api repos/$R/traffic/views --jq '"views14d: \(.count) uniques \(.uniques)"' 2>/dev/null
gh api repos/$R/traffic/clones --jq '"clones14d: \(.count) uniques \(.uniques)"' 2>/dev/null
gh api repos/$R/traffic/popular/referrers --jq '.[]|"  ref \(.referrer) \(.count)/\(.uniques)"' 2>/dev/null
gh api repos/$R/stargazers --jq '.[].login' 2>/dev/null | tr '\n' ' '; echo
gh api repos/$R/issues/1 --jq '"waitlist issue #1: 👍 \(.reactions["+1"]) comments \(.comments)"'
gh api "repos/$R/issues?state=all&per_page=50" --jq '.[]|select(.number>2)|"  issue/pr #\(.number) by \(.user.login): \(.title[0:60])"'
gh api "repos/anthropics/claude-code/issues/comments/6020513180" --jq '"65961 my comment reactions: \(.reactions.total_count) (+1 \(.reactions["+1"]), heart \(.reactions.heart), rocket \(.reactions.rocket))"'
gh api "repos/anthropics/claude-code/issues/65961/comments?per_page=100&since=2026-10-06T16:05:00Z" --jq '.[]|select(.user.login!="sami-abdul")|"  65961 new: \(.created_at) \(.user.login): \(.body[0:160]|gsub("\n";" "))"'
for d in "openai codex 51406" "anthropics claude-code-action 1884"; do set -- $d; gh api graphql -f query="{repository(owner:\"$1\",name:\"$2\"){discussion(number:$3){upvoteCount comments(first:10){totalCount nodes{author{login} body}}}}}" --jq ".data.repository.discussion|\"disc $1/$2#$3: up \(.upvoteCount) comments \(.comments.totalCount)\""; done
for p in "jqueryscript/awesome-claude-code 736" "rohitg00/awesome-claude-code-toolkit 825"; do set -- $p; gh api repos/$1/pulls/$2 --jq "\"PR $1#$2: \(.state) merged=\(.merged)\""; done
python3 "$(dirname "$0")/mail.py" nocomment 2>/dev/null | grep -v "Activate FormSubmit" | tail -5
curl -s -m 15 https://arb1.arbitrum.io/rpc -H 'content-type: application/json' -d '{"jsonrpc":"2.0","id":1,"method":"eth_call","params":[{"to":"0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9","data":"0x70a0823100000000000000000000000036c37d1b47737ba2b2a2cf1b5bc38509516b222f"},"latest"]}' | python3 -c "import json,sys; print('USDT(Arb) balance:', int(json.load(sys.stdin)['result'],16)/1e6)"
ls /home/mac-home-lab/Projects/swarm/approvals/resolved/ 2>/dev/null | grep r01-a4
