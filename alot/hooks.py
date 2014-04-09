import logging
from subprocess import call
def post_envelope_send(**kwargs):
    logging.info('calling "notmuch new!"')
    call(["notmuch", "new"])
