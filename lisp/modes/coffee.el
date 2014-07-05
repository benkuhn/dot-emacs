;; 2-space tabs
(add-hook 'coffee-mode-hook (defun coffee-custom ()
  "hook run for coffee-mode"
  (local-set-key "\C-j" 'coffee-newline-and-indent)
  (flycheck-mode)
  (auto-complete-mode)))
