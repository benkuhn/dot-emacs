(require 'org)

(setq org-directory "~/Documents/org")
(setq
  org-agenda-files (list org-directory)
  org-agenda-window-setup 'other-window
  org-default-notes-file (concat org-directory "/tasks.org")
  org-agenda-span 1
  org-mobile-inbox-for-pull (concat org-directory "/flagged.org")
  org-mobile-directory "~/Dropbox/Apps/MobileOrg"
  org-startup-indented t)

(setq my-followup-file (concat org-directory "/followup.org"))
(setq org-capture-templates '(("f" "Followup" entry (file+headline my-followup-file "Followups")
                               "* TODO Follow up on [[%l][%:subject]]")
                              ("r" "Response" entry (file+headline my-followup-file "Responses")
                               "* TODO Reply to %a")
                              ("t" "Todo" entry (file+headline org-default-notes-file "Non-recurring")
                               "* TODO %?\n  %i\n  %a"))
      dummy-to-stop-pp t)

;; folding makes linum unhappy
(add-hook 'org-mode-hook
          (defun my-make-linum-nice ()
            (linum-mode 0)))

;;; based on smart-beginning-of-line from funcs.el
(defun org-smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (org-beginning-of-line))))

;; Don't do this since it's not as helpful with org-indent-mode
;; (add-hook 'org-mode-hook
;;           (defun my-org-keybindings ()
;;             (local-set-key "\C-a" 'org-smart-beginning-of-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Org mobile stuff: sync automatically
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-mobile-force-id-on-agenda-items nil)
(defun org-mobile-sync ()
  (interactive)
  (org-mobile-push)
  (org-mobile-pull))
(add-hook 'midnight-hook 'org-mobile-sync)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Effort estimates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-global-properties
        '(("Effort_ALL" . "0 0:05 0:15 0:30 1:00 1:30 2:00")))

(concat "a" "b")

(defun agenda-gtd (hotkey tags)
  `(,hotkey ,(concat "Tagged with " tags)
            ((tags-todo "+time")
             (agenda ,tags)
             (tags-todo ,(concat tags "-time")))
            ((org-agenda-todo-ignore-scheduled t)
             (org-agenda-todo-ignore-deadlines t))
  ))

(agenda-gtd "h" "+home")

(setq org-agenda-custom-commands
      `(
        ,(agenda-gtd "h" "+home")
        ,(agenda-gtd "p" "+phone")
        ,(agenda-gtd "e" "+errands")
        ,(agenda-gtd "t" "+time")
        ,(agenda-gtd "r" "+create")
        ,(agenda-gtd "o" "+consume")
        ,(agenda-gtd "b" "+busy")
        ,(agenda-gtd "h" "+home")
        ,(agenda-gtd "a" "")
        ))

(setq org-agenda-dim-blocked-tasks 'invisible)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-enforce-todo-dependencies t)
(setq org-track-ordered-property-with-tag "seq")
