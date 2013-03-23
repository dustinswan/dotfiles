import subprocess

def gmail_password():
    path = "/Users/dustinswan/.gmail_password.gpg"
    args = ["gpg", "-d", path]
    try:
        return subprocess.check_output(args).rstrip()
    except subprocess.CalledProcessError:
        return "".strip()
