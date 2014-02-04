(require 'linum)
(global-linum-mode 1)

;; don't run in modes I don't like
(setq linum-blacklist '(org-mode doc-view-mode dired-mode))

;; override the function that turns on linum mode
(defun linum-on ()
  (unless (or (member major-mode linum-blacklist)
              (string-match "*" (buffer-name))
              (minibufferp))
    (linum-mode 1)))

