;; this is the worst way of defining keybindings :(
(eval-when-compile (require 'jedi nil t))
(setq jedi:setup-keys t)
(setq jedi:key-goto-definition (kbd "C-c ."))
(add-hook 'python-mode-hook 'jedi:setup)

(defun flymake-pylint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                        temp-;FIXME: le
                        (file-name-directory buffer-file-name))))
    (list "epylint" (list local-file)))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))