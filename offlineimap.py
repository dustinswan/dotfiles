#import subprocess
import os
import gnupg

home = os.environ['HOME']
gpg = gnupg.GPG(gnupghome=home+"/.gnupg", use_agent=True)

def gmail_password():
    path = os.environ['HOME'] + "/.gmail-password.gpg"
    #args = ["gpg", "-d", path]
    f = open(path, 'rb')
    decrypted = gpg.decrypt_file(f)
    return decrypted.data.strip()

    #try:
        #return subprocess.check_output(args).rstrip()
    #except subprocess.CalledProcessError:
        #return "".strip()

def iocom_password():
    path = os.environ['HOME'] + "/.iocom-password.gpg"
    f = open(path, 'rb')
    decrypted = gpg.decrypt_file(f)
    return decrypted.data.strip()
    #args = ["gpg", "-d", path]
    #try:
        #return subprocess.check_output(args).rstrip()
    #except subprocess.CalledProcessError:
        #return "".strip()
