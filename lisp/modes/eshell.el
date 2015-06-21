(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize (concat " " (abbreviate-file-name (eshell/pwd)) " ") 'face 'bsk/eshell-dir)
         (propertize "$" 'display (powerline-arrow-left 'bsk/eshell-dir 'default))
         " ")))

(setq eshell-highlight-prompt nil)
