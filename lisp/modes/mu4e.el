;;; mu4e setup
(require 'mu4e)
(require 'org-mu4e)

;;; Maildir config
(setq
  mu4e-maildir "~/Maildir"
  mu4e-drafts-folder "/[Gmail].All Mail"
  mu4e-sent-folder   "/[Gmail].All Mail"
  mu4e-trash-folder  "/[Gmail].Trash")

(setq
  ;;; don't save message to Sent Messages, Gmail/IMAP takes care of this
  mu4e-sent-messages-behavior 'delete
  ;;; put attachments in Downloads
  mu4e-attachment-dir  "~/Downloads"
  ;;; user info
  user-mail-address "ben.s.kuhn@gmail.com"
  user-full-name  "Ben Kuhn"
  message-signature nil
  ;;; allow for updating mail using 'U' in the main view:
  mu4e-get-mail-command "python ~/build/offlineimap/offlineimap.py"
  ;;; don't keep message buffers around
  message-kill-buffer-on-exit t
  ;;; don't show the whole thread in the inbox
  mu4e-headers-include-related nil
  ;;; don't show duplicates
  mu4e-headers-skip-duplicates t
  ;;; nice HTML rendering
  mu4e-html2text-command "w3m -dump -cols 80 -T text/html"
  ;;; convert org-mode messages to multipart with HTML rich text
  org-mu4e-convert-to-html t
  ;;; fancy chars
  ;; mu4e-headers-seen-mark '("S" . "☑") ;seen
  ;; mu4e-headers-unread-mark '("u" . "☐") ; unseen
  ;; mu4e-headers-flagged-mark '("F" .  "⚵")  ;flagged
  ;; mu4e-headers-new-mark '("N" .  "✉")  ;new
  ;; mu4e-headers-replied-mark '("R" . "↵") ;replied
  ;; mu4e-headers-passed-mark '("P" . "⇉") ;passed
  ;; mu4e-headers-encrypted-mark '("x" . "⚷") ;encrypted
  ;; mu4e-headers-signed-mark '("s" . "✍") ;signed
  mu4e-use-fancy-chars nil
  )

;;; one-key mailbox shortcuts
(setq mu4e-maildir-shortcuts
    '( ("/[Gmail].Trash"       . ?t)
       ("/[Gmail].All Mail"    . ?a)))

(setq mu4e-bookmarks
      '( ("x:\\\\Inbox" "Inbox" ?i)
         ("x:\\\\Sent"  "Sent"  ?s)
         ("x:To-Do"     "To Do" ?t)))

;;; sending mail
(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-stream-type 'starttls
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;;; Emacs default mail program
(setq mail-user-agent 'mu4e-user-agent)

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

;;; tagging actions
(defmacro tag-action (sym1 tags)
  (let* ((str (symbol-name sym1))
         (sym (intern (concat str "-message"))))
    `(defun ,sym (msg)
       ,(concat "Apply the tag string \"" tags "\" to the message.")
       (mu4e-action-retag-message msg ,tags))))

(tag-action archive   "-\\Inbox")
(tag-action unarchive "+\\Inbox")
(tag-action todoify   "+To-Do")
(tag-action finish    "-To-Do")

;;; reindex
(define-key mu4e-main-mode-map "I" 'mu4e-update-index)
(define-key mu4e-headers-mode-map "I" 'mu4e-update-index)
(define-key mu4e-view-mode-map "I" 'mu4e-update-index)

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

;;; send function that does extra stuff (like ask for a reminder)
(defun my-message-send-and-exit ()
  (interactive)
  (my-add-followup)
  (message-send-and-exit))
(define-key mu4e-compose-mode-map (kbd "C-c C-c") 'my-message-send-and-exit)

;;; mu4e-followup: on sending a message, ask for a followup date, and
;;; capture a to-do if necessary

(defun my-add-uuid ()
  (unless (boundp 'uuid)
    (setq-local uuid (format "%04x%04x-%04x-%04x-%04x-%06x%06x"
                             (random (expt 16 4))
                             (random (expt 16 4))
                             (random (expt 16 4))
                             (random (expt 16 4))
                             (random (expt 16 4))
                             (random (expt 16 6))
                             (random (expt 16 6))))
    (message-add-header (concat "X-mu4e-UUID: " uuid))))

(defun my-add-view-followup (msg)
  (interactive)
  (let ((time (org-read-date nil nil nil "Follow up in (leave blank for none):")))
    (org-capture nil "r")
    (org-deadline 0 time)
    (org-capture-finalize)
    (archive-message msg)))

(add-to-list 'mu4e-view-actions '("Ccapture for org mode" . my-add-view-followup))

(defun my-add-followup ()
  (interactive)
  (let ((time (org-read-date nil nil nil "Follow up in (leave blank for none):")))
    (unless (string= time (org-read-date nil nil ""))
      (my-add-uuid)
      (org-capture nil "f")
      (org-deadline 0 time)
      (org-capture-finalize)
  )))

(org-add-link-type "followup" 'org-followup-open)
(defun org-followup-open (uuid)
  "Visit the message with the given uuid."
  ; (mu4e~proc-find...
  )
(defun org-followup-store-link ()
  "Store a link to a manpage."
  (when (eq major-mode 'mu4e-compose-mode)
    ;; This is an email, we do make this link
    (org-store-link-props
     :type "followup:"
     :link (concat "followup:" uuid)
     :subject (message-get-subject)
     )))

(defun message-get-subject ()
  (save-excursion
    (message-goto-subject)
    (buffer-substring-no-properties
     (save-excursion
       (beginning-of-line)
       (forward-char 9)
       (point))
     (point))))
(add-hook 'org-store-link-functions 'org-followup-store-link)

(org-add-link-type "reply" 'org-reply-open)
