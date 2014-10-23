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

(after 'auto-complete
  (diminish 'auto-complete-mode ""))
(after 'ropemacs
  (diminish 'ropemacs-mode ""))
(after 'yasnippet
  (diminish 'yas-minor-mode ""))
(after 'magit
  (diminish 'magit-auto-revert-mode ""))
(after 'undo-tree
  (diminish 'undo-tree-mode ""))
(after 'helm
  (diminish 'helm-mode ""))
