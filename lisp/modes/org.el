(require 'org)

(setq org-directory "~/Documents/org")
(setq
  org-agenda-files (list org-directory)
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

(add-hook 'org-mode-hook
          (defun my-org-keybindings ()
            (local-set-key "\C-a" 'org-smart-beginning-of-line)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Org mobile stuff: sync automatically
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-mobile-force-id-on-agenda-items nil)
(add-hook 'auto-save-hook
          (defun org-mobile-sync ()
            (interactive)
            (org-mobile-pull)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Effort estimates
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-global-properties
        '(("Effort_ALL" . "0 0:05 0:15 0:30 1:00 1:30 2:00")))
(setq org-agenda-custom-commands
      `(("b" "custom" agenda "Ben's custom agenda"
         ((org-agenda-ndays 8)
          (org-agenda-start-day "+0d")
          (org-agenda-overriding-columns-format
           "%25ITEM %TODO %15DEADLINE %3PRIORITY %4Effort{:} %CLOCKSUM_T")
          (org-deadline-warning-days 0)
          (org-agenda-prefix-format
           '((agenda . "%7e %s")
             (timeline . "  % s")
             (todo . " %i %-12:c")
             (tags . " %i %-12:c")
             (search . " %i %-12:c")))
          (org-agenda-sorting-strategy
           '(todo-state-down habit-down effort-down category-keep))
          ))))
