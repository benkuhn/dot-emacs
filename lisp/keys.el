;;; better keybindings.
;; easier to hit than M-x
(global-set-key (kbd "C-.") 'execute-extended-command)
;; TODO make this pick between backward-kill-word and kill-region
(global-set-key "\C-w" 'backward-kill-word)
;; C-x b foo C-x k
(global-set-key "\C-xk" 'kill-this-buffer)
;; TODO I don't want to bind this :(
(global-set-key "\C-x\C-k" 'kill-region)
(define-key key-translation-map "\C-h" "\C-?")
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "C-x M-%") 'replace-string)
(global-set-key "\C-x\C-r" 'query-replace-regexp)
(global-set-key (kbd "\C-x r S") 'string-insert-rectangle)
(global-set-key "\C-a" 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)
(global-set-key "\M-Y" 'yank-pop-forwards)
(global-set-key "\M-Q" 'unfill-paragraph)
(global-set-key (kbd "C-x C-4") 'mu4e)

(global-set-key (kbd "C-M-S-q") 'quit-other-window)

;;; org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; magit
(global-set-key "\C-xg" 'magit-status)
