;;; mu4e setup
(require 'mu4e)
(require 'org-mu4e)

;;; Maildir config
(setq
  mu4e-maildir       "~/Maildir"
  mu4e-drafts-folder "/[Gmail].Drafts"
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
  org-mu4e-convert-to-html t)

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
;(setq mail-user-agent 'gnus-user-agent)

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
    `(progn
       (defun ,sym (msg)
         ,(concat "Apply the tag string \"" tags "\" to the message.")
         (mu4e-action-retag-message msg ,tags))
       (add-to-list 'mu4e-view-actions '(,str . ,sym))
       (add-to-list 'mu4e-headers-actions '(,str . ,sym))
       )))

(tag-action finish    "-To-Do")
(tag-action todoify   "+To-Do")
(tag-action unarchive "+\\Inbox")
(tag-action archive   "-\\Inbox")

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Nice HTML composition
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (add-hook 'mu4e-compose-pre-hook
;;   (defun my-store-own-quoting ()
;;     "Quote the user my own way."
;;     (if (eq nil mu4e-compose-parent-message)
;;         (setq my-quoted-text "")
;;       (setq my-quoted-text (my-quote-text-of-msg mu4e-compose-parent-message)))))

;;; use visual lines and flow text
(add-hook 'mu4e-compose-mode-hook
   (defun my-start-format-flowed ()
     (auto-fill-mode 1)
     (visual-line-mode 1)
     ;(message-goto-body)
     ;(kill-region (point) (point-max))
     ;(message "inserting")
     ;(insert my-quoted-text)
     ;(makunbound 'my-quoted-text)
     ;(message-goto-body)
     ))

;; (defun my-make-message-multipart ()
;;   "Replace the message with a multipart message."
;;   (interactive)
;;   (message-goto-body)
;;   (let ((html (with-output-to-string
;;                 (shell-command-on-region
;;                  (point) (point-max)
;;                  "pandoc -f markdown -t html" standard-output)))
;;         (text (buffer-substring (point) (point-max))))
;;     (kill-region (point) (point-max))
;;     (insert
;;      "<#multipart type=alternative>"
;;      "<#part type=text/plain>"
;;      text
;;      "<#part type=text/html>"
;;      html
;;      "<#/multipart>")))

;; (defun my-quote-text-of-msg (msg)
;;   "View the body of the message in a web browser."
;;   (interactive (list (mu4e-message-at-point)))
;;   (let* ((html (mu4e-msg-field msg :body-html))
;;          (txt  (mu4e-msg-field msg :body-txt))
;;          (tmpfile (format "%s%d" temporary-file-directory (random))))
;;     (cond
;;      (html
;;       (with-temp-file tmpfile
;;         (insert "<blockquote>\n" html "\n</blockquote>\n"))
;;       (message "temporary file: %s" tmpfile)
;;       (shell-command-to-string (concat "pandoc -f html -t markdown " tmpfile)))
;;      (txt
;;       (mapconcat 'identity (split-string txt "\n") "\n> "))
;;      (t (error "No contents for this message")))
;;     ))

;;; send function that does extra stuff:
;;; - ask for a reminder
;;; - turn markdown into a multipart message
(defun my-message-send-and-exit ()
  (interactive)
  (my-add-followup)
  (message-send-and-exit))
(define-key mu4e-compose-mode-map (kbd "C-c C-c") 'my-message-send-and-exit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; mu4e-followup: on sending a message, ask for a followup date, and
;;; capture a to-do if necessary
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-add-view-followup (msg)
  (interactive)
  (let ((time (org-read-date nil nil nil "Follow up in (leave blank for none):")))
    (org-capture nil "r")
    (org-schedule 0 time)
    (org-capture-finalize)
    (archive-message msg)))

(add-to-list 'mu4e-view-actions '("Ccapture for org mode" . my-add-view-followup))

(defun my-add-followup ()
  (interactive)
  (let ((time (org-read-date nil nil nil "Follow up in (leave blank for none):")))
    (unless (string= time (org-read-date nil nil ""))
      (org-capture nil "f")
      (org-schedule 0 time)
      (org-capture-finalize)
  )))

(org-add-link-type "followup" 'org-followup-open)
(defun org-followup-open (subject)
  "Visit the message with the given uuid."
  (require 'mu4e)
  (org-mu4e-open (concat "query:subject:\"" subject "\""))
  )
(defun org-followup-store-link ()
  "Store a link to a manpage."
  (when (eq major-mode 'mu4e-compose-mode)
    ;; This is an email, we do make this link
    (let ((subject (message-get-subject)))
      (org-store-link-props
       :type "followup:"
       :link (concat "followup:" subject)
       ; remove [] so org-mode links work
       :subject (de-square-bracket subject)
       ))))
(defun de-square-bracket (str)
  (replace-regexp-in-string "\\[" "{" (replace-regexp-in-string "\\]" "}" str)))

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
