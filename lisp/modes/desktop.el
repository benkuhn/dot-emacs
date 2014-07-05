(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
;; source: http://draketo.de/light/english/emacs/babcore
(setq desktop-globals-to-save
      (append '((extended-command-history . 300)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 5000)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 2000)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))
