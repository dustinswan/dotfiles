def gmail_password():
    path = "~/.gmail_password.pgp"
    args = ["gpg", "--use-agent", "--quiet", "--batch", "-d", path]
    try:
        return subprocess.check_output(args)
    except subprocess.CalledProcessError:
        return "".strip()
