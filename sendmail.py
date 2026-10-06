#!/usr/bin/env python3
"""Send one plain-text email from the brand alias. Usage: sendmail.py to subject bodyfile"""
import smtplib, os, sys
from email.message import EmailMessage
env = {}
for l in open(os.path.expanduser('~/.config/swarm/secrets.env')):
    if '=' in l and not l.startswith('#'):
        k, v = l.strip().split('=', 1); env[k] = v.strip().strip('"').strip("'")
to, subj, bf = sys.argv[1], sys.argv[2], sys.argv[3]
m = EmailMessage()
m['From'] = 'No Comment <megafi.app1+nocomment@gmail.com>'
m['Reply-To'] = 'megafi.app1+nocomment@gmail.com'
m['To'] = to; m['Subject'] = subj
m.set_content(open(bf).read())
with smtplib.SMTP_SSL('smtp.gmail.com', 465) as s:
    s.login(env['BRAND_GMAIL_ADDRESS'], env['BRAND_GMAIL_APP_PASSWORD'].replace(' ', ''))
    s.send_message(m)
print('sent to', to)
