;;; better keybindings.
;; easier to hit than M-x
(global-set-key (kbd "C-.") 'execute-extended-command)
;; if no active region, do backward-delete-word
(global-set-key (kbd "C-w") 'my-c-w)
;; C-x b foo C-x k
(global-set-key "\C-xk" 'kill-this-buffer)
;; C-h should backspace
(define-key key-translation-map "\C-h" "\C-?")
(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "C-x M-%") 'replace-string)
;; qrr is awesome and useful
(global-set-key "\C-x\C-r" 'query-replace-regexp)
;; recent file
;; TODO better autocompletion (e.g. icicles?)
(global-set-key (kbd "M-g r") 'recentf-open-files)
;; as is s-i-r
(global-set-key (kbd "\C-x r S") 'string-insert-rectangle)
;; Eclipse-like beginning of line
(global-set-key "\C-a" 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)
;; more convenient things
(global-set-key "\M-Y" 'yank-pop-forwards)
(global-set-key "\M-Q" 'unfill-paragraph)
;; freaking completion/help buffers sticking around all the time
(global-set-key (kbd "C-M-S-q") 'quit-other-window)
;; by analogy to C-x l
(global-set-key (kbd "C-x w") 'count-words)
;; I never use open-line, but use other-window a lot
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "C-O") 'other-window)
(global-unset-key (kbd "C-x o")) ;; hack to break old habit

;;; program shortcuts
(global-set-key (kbd "C-x C-4") 'mu4e)

;;; org mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;;; magit
(global-set-key "\C-xg" 'magit-status)
