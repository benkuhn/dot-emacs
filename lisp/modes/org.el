(require 'org)

(setq org-directory "~/Documents/org")
(setq
  org-agenda-files (list org-directory)
  org-default-notes-file (concat org-directory "/tasks.org")
  org-agenda-span 1
  org-mobile-inbox-for-pull (concat org-directory "/flagged.org")
  org-mobile-directory "~/Dropbox/Apps/MobileOrg")

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
