(require 'org)

(setq org-directory "~/Documents/org")
(setq
  org-agenda-files (list org-directory)
  org-agenda-span 1
  org-mobile-inbox-for-pull (concat org-directory "/flagged.org")
  org-mobile-directory "~/Dropbox/Apps/MobileOrg")

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; folding makes linum unhappy
; (setq org-mode-hook nil)
(add-hook 'org-mode-hook
          (defun my-make-linum-nice ()
            (linum-mode 0)))
