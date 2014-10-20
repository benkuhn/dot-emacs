(after 'flymake
  (message "configuring flymake")
  ;; sigh, Flymake has no keymap, so we add these globally :(
  (global-set-key (kbd "M-n") 'flymake-goto-next-error)
  (global-set-key (kbd "M-p") 'flymake-goto-prev-error)
  (global-set-key (kbd "M-m") 'flymake-display-err-menu-for-current-line))
