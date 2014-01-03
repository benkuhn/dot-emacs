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
                               "* TODO Follow up on [[%l][%:subject]]"))
      dummy-to-stop-pp t)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; folding makes linum unhappy
; (setq org-mode-hook nil)
(add-hook 'org-mode-hook
          (defun my-make-linum-nice ()
            (linum-mode 0)))
