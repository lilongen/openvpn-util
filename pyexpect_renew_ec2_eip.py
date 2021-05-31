#!/usr/bin/env python
# coding: utf-8
#

import sys
import pexpect
import subprocess
import time

terraform = 'terraform -chdir=./terraform'
print('destory last created eip ...')
child = pexpect.spawn(f'{terraform} destroy', logfile=sys.stdout.buffer)
child.expect('.*Enter a value:.*')
child.sendline('yes')
child.interact()
print('destory last created eip ... done')

time.sleep(3)

print('renew ec2 eip ...')
print('terraform plan ...')
ret = subprocess.check_output(f'{terraform} plan', shell=True).decode()
print(ret)
print('terraform plan ... done')


print('terraform apply ...')
child = pexpect.spawn(f'{terraform} apply', logfile=sys.stdout.buffer)
child.expect('.*Enter a value:.*')
child.sendline('yes')
child.interact()
print('terraform apply ... done')
print('renew ec2 eip ... done!')
