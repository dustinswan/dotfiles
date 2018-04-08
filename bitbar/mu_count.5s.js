#!/usr/bin/env /usr/local/bin/node
const bitbar = require('bitbar');
const exec = require('child_process').exec;

let cmd = `/usr/local/bin/mu find flag:unread AND NOT flag:trashed AND \\(maildir:/Fastmail/INBOX OR maildir:/IOCOM/INBOX\\) --fields \"l f s\"`;

exec(cmd, function(error, stdout, stderr) {

  let mails = stderr.match(/no matches/)
    ? []
    : stdout.trim().split("\n").map(parseMailString);

  bitbar([
    ':envelope: ' + mails.length || "",
    bitbar.sep,
    ...mails
  ]);

});

function parseMailString(m) {
  const MAX = 80;

  let matches = m.match(/([^\s]+)\s(.*)/);

  let filename = matches[1];
  let text = matches[2].substring(0, MAX) + (matches[2].length > MAX ? "..." : "");

  return {
    text,
    bash: "/usr/local/bin/emacsclient -n " + filename,
    terminal: false
  }
}
