;;; load everything in the modes/ directory
(dolist (fname (directory-files "~/.emacs.d/lisp/modes"))
  (if (and (> (length fname) 3) (string= (substring fname -3) ".el"))
      (load-library (concat "modes/" fname))))

;;; ido
(require 'ido-ubiquitous)
(ido-mode)
(setq ido-ignore-extensions t)
(ido-ubiquitous-mode 1)

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

;;; w3m customizations
(setq w3m-default-display-inline-images t)

;;; for LaTeX: auto-refresh PDF buffers
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;;; powerline
(require 'powerline)
(face-attribute 'mode-line :background)
(powerline-default-theme)
