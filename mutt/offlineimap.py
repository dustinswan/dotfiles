import subprocess
import os

def gmail_password():
    path = os.environ['HOME'] + "/.gmail_password.gpg"
    args = ["gpg", "-d", path]
    try:
        return subprocess.check_output(args).rstrip()
    except subprocess.CalledProcessError:
        return "".strip()
