(require 'linum)
(global-linum-mode 1)

;; don't run in modes I don't like
(setq linum-blacklist '(doc-view-mode dired-mode org-mode))

;; override the function that turns on linum mode
(defun linum-on ()
  (unless (or (member major-mode linum-blacklist)
              (string-match "*" (buffer-name))
              (minibufferp))
    (linum-mode 1)))

(defun linum-format-func (line)
  (propertize (format "%3d" line) 'face 'linum))
(setq linum-format 'linum-format-func)
