;;; better keybindings.
;; if no active region, do backward-delete-word
(global-set-key (kbd "C-w") 'my-c-w)
;; C-x b foo C-x k
(global-set-key "\C-xk" 'kill-this-buffer)
;; C-h should backspace
(define-key key-translation-map "\C-h" "\C-?")
(global-set-key (kbd "M-?") 'help-command)
(global-set-key (kbd "C-x M-%") 'replace-string)
;; regexp isearch
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-S") 'isearch-forward)
(global-set-key (kbd "C-R") 'isearch-backward)
;; recent file
(global-set-key (kbd "M-g r") 'helm-recentf)
;; qrr is awesome and useful
(global-set-key "\C-x\C-r" 'query-replace-regexp)
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

;;; duplicate line
(global-set-key "\C-c\C-d" 'duplicate-line)

;;; zen mode
(global-set-key "\C-x\C-z" 'zen-mode)

;;; helm etc
(global-set-key (kbd "C-.") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "s-t") 'helm-projectile)
