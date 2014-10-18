;; this is the worst way of defining keybindings :(
(eval-when-compile (require 'jedi nil t))
(setq jedi:setup-keys t)
(setq jedi:key-goto-definition (kbd "C-c ."))
(setq jedi:get-in-function-call-delay 0)
(add-hook 'python-mode-hook 'jedi:setup)

;; Rope mode... see http://milkbox.net/note/installing-pymacs-rope-on-emacs-24/
(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

;; Flymake pylint
(defun flymake-pylint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    ; TODO(ben): incorporate --rcfile
    (list "epylint" (list local-file))))
  
(add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init))

(add-hook 'python-mode-hook 'my-setup-python)

(defun my-setup-python ()
  (add-hook 'before-save-hook 'delete-trailing-whitespace 't 't)
  (flymake-mode 1))
