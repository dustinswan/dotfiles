import os
import gnupg

home = os.environ['HOME']
gpg = gnupg.GPG(gnupghome=home+"/.gnupg", use_agent=True)

def decrypt_password(file):
    path = home + "/" + file
    f = open(path, 'rb')
    decrypted = gpg.decrypt_file(f)
    return decrypted.data.strip()
