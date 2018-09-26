import os
from subprocess import check_output

home = os.environ['HOME']

def decrypt_password(file):
    path = home + "/" + file
    res = check_output(["gpg", "-dq", path])
    return res.strip()
