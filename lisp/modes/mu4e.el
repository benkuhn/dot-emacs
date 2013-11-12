;;; mu4e setup
(require 'mu4e)

;;; default, but whatever
(setq mu4e-maildir "~/Maildir")

(setq mu4e-drafts-folder "/[Gmail].Drafts")
(setq mu4e-sent-folder   "/[Gmail].Sent Mail")
(setq mu4e-trash-folder  "/[Gmail].Trash")

;;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;;; one-key mailbox shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/INBOX"               . ?i)
       ("/[Gmail].Sent Mail"   . ?s)
       ("/[Gmail].Drafts"      . ?d)
       ("/[Gmail].Trash"       . ?t)
       ("/To Do"               . ?T)
       ("/[Gmail].All Mail"    . ?a)))

;;; allow for updating mail using 'U' in the main view:
(setq
   mu4e-get-mail-command "offlineimap"
   mu4e-headers-include-related t
   mu4e-headers-skip-duplicates t)

;;; user info
(setq
   user-mail-address "ben.s.kuhn@gmail.com"
   user-full-name  "Ben Kuhn"
   message-signature nil)

;;; sending mail
(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
     smtpmail-stream-type 'starttls
     smtpmail-default-smtp-server "smtp.gmail.com"
     smtpmail-smtp-server "smtp.gmail.com"
     smtpmail-smtp-service 587)

;;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;;; view in browser action
(defun mu4e-msgv-action-view-in-browser (msg)
  "View the body of the message in a web browser."
  (interactive)
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (unless html (error "No html part for this message"))
    (with-temp-file tmpfile
      (insert
       "<html>"
       "<head><meta http-equiv=\"content-type\""
       "content=\"text/html;charset=UTF-8\">"
       html))
    (browse-url (concat "file://" tmpfile))))

(add-to-list 'mu4e-view-actions
             '("View in browser" . mu4e-msgv-action-view-in-browser) t)

;;; Emacs default mail program
(setq mail-user-agent 'mu4e-user-agent)

;;; stored usernames/passwords
(setq auth-sources '((:source "~/.authinfo" :host t :protocol t)))

;;; wrap lines in message view
(add-hook 'mu4e-view-mode-hook 'turn-on-visual-line-mode)
