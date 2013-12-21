;;; mu4e setup
(require 'mu4e)

;;; Maildir config
(setq
  mu4e-maildir "~/Maildir"
  mu4e-drafts-folder "/[Gmail].Drafts"
  mu4e-sent-folder   "/[Gmail].Sent Mail"
  mu4e-trash-folder  "/[Gmail].Trash")

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
(setq mu4e-get-mail-command "offlineimap")

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

;;; Emacs default mail program
(setq mail-user-agent 'mu4e-user-agent)

;;; misc customizations
(setq
  message-kill-buffer-on-exit t     ;;; don't keep message buffers around
  mu4e-headers-include-related nil  ;;; don't show the whole thread in the inbox
  mu4e-headers-skip-duplicates t    ;;; don't show duplicates
  mu4e-html2text-command "w3m -dump -cols 80 -T text/html") ;;; nice HTML rendering

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

;;; stored usernames/passwords
(setq auth-sources '((:source "~/.authinfo" :host t :protocol t)))

;;; wrap lines in message view
(add-hook 'mu4e-view-mode-hook 'turn-on-visual-line-mode)

;;; check for proper from: address when composing
(setq my-from-addresses
      '(("gmail" . "ben.s.kuhn@gmail.com")
        ("harvard" . "bkuhn@college.harvard.edu")))
(setq mu4e-user-mail-address-list (mapcar 'cdr my-from-addresses))

(defun choose-from-address ()
  (mu4e-read-option "Choose a From address: " my-from-addresses))
(defun parent-addressed-to (addr)
  (flet ((matches (sym) (mu4e-message-contact-field-matches mu4e-compose-parent-message sym addr)))
    (or (matches :to) (matches :cc) (matches :bcc))))

(defun find-in-list (lst fun default)
  (let ((elt (car lst)))
    (cond
      ((eq lst nil) (funcall default))
      ((funcall fun elt) elt)
      (t (find-in-list (cdr lst) fun default)))))

;;; source: http://www.djcbsoftware.nl/code/mu/mu4e/Compose-hooks.html#Compose-hooks.
;;; modified to read from my-from-addresses and ask if we don't know
(add-hook 'mu4e-compose-pre-hook
  (defun my-set-from-address ()
    "Set the From address based on the To address of the original."
    (setq user-mail-address
          (if (eq nil mu4e-compose-parent-message)
              (choose-from-address)
            (find-in-list
             (mapcar 'cdr my-from-addresses)
             'parent-addressed-to
             'choose-from-address)))))

;;; use visual lines and flow text
(add-hook 'mu4e-compose-mode-hook
   (defun my-start-format-flowed ()
     (auto-fill-mode 1)
     (visual-line-mode 1)))

(defun convert-long-to-flowed-lines ()
  )
(defun convert-flowed-to-long-lines ()
  )
(defun my-message-send-and-exit ()
  (progn
    (message-send-and-exit)))

;; (define-key mu4e-compose-mode-map (kbd "C-c C-c") 'my-message-send-and-exit)
