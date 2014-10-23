;;; load everything in the modes/ directory
(dolist (fname (directory-files "~/.emacs.d/lisp/modes"))
  (if (and (> (length fname) 3) (string= (substring fname -3) ".el"))
      (load-library (concat "modes/" fname))))

;;; nicer filenames
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;;; recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

;;; text mode
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;;; kill unused buffers
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")
(setq clean-buffer-list-delay-general 10)

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

;;; w3m customizations
(setq w3m-default-display-inline-images t)

;;; for LaTeX: auto-refresh PDF buffers
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;;; powerline
(require 'powerline)
(powerline-default-theme)

;;; undo tree
(require 'undo-tree)
(global-undo-tree-mode 1)

;;; Helm/Projectile
; global mode always on, so no lighter
(require 'helm)
(require 'helm-projectile)
(require 'projectile)
(setq helm-completion-mode-string "")
(helm-mode 1)
(projectile-global-mode 1)
(helm-projectile-on)

(diminish 'auto-complete-mode "")
(diminish 'ropemacs-mode "")
(diminish 'yas-minor-mode "")
(diminish 'magit-auto-revert-mode "")
(diminish 'undo-tree-mode "")
