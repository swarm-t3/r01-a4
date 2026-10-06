#!/usr/bin/env python3
"""Search the shared brand inbox for mail to our alias. Usage: mail.py [search-term] [--body]"""
import imaplib, email, os, sys, re
from email.header import decode_header
env = {}
for l in open(os.path.expanduser('~/.config/swarm/secrets.env')):
    if '=' in l and not l.startswith('#'):
        k, v = l.strip().split('=', 1); env[k] = v.strip().strip('"').strip("'")
M = imaplib.IMAP4_SSL('imap.gmail.com', 993)
M.login(env['BRAND_GMAIL_ADDRESS'], env['BRAND_GMAIL_APP_PASSWORD'].replace(' ', ''))
M.select('INBOX', readonly=True)
term = sys.argv[1] if len(sys.argv) > 1 and not sys.argv[1].startswith('--') else 'nocomment'
typ, data = M.search(None, '(OR TO "%s" TEXT "%s")' % ('megafi.app1+' + term, term))
ids = data[0].split()[-15:]
for i in ids:
    typ, d = M.fetch(i, '(RFC822)')
    m = email.message_from_bytes(d[0][1])
    subj = ''.join(t.decode(c or 'utf8') if isinstance(t, bytes) else t for t, c in decode_header(m['Subject'] or ''))
    print('---', m['Date'], '|', m['From'], '|', m['To'], '|', subj)
    if '--body' in sys.argv:
        for part in m.walk():
            if part.get_content_type() == 'text/plain':
                print(part.get_payload(decode=True).decode('utf8', 'replace')[:1500]); break
            if part.get_content_type() == 'text/html':
                h = part.get_payload(decode=True).decode('utf8', 'replace')
                print(re.findall(r'https?://[^"\'\s<>]+', h)[:10]); 
