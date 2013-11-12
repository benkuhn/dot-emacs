;; 2-space tabs
(defun coffee-custom ()
  "hook run for coffee-mode"
  (local-set-key "\C-j" 'coffee-newline-and-indent))
(add-hook 'coffee-mode-hook 'coffee-custom)
