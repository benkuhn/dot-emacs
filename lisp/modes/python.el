(after 'python
  (message "configuring Python mode")
  ;; this is the worst way of defining keybindings :(
  (eval-when-compile (require 'jedi nil t))
  (setq jedi:setup-keys t)
  (setq jedi:key-goto-definition (kbd "C-c ."))
  (setq jedi:get-in-function-call-delay 0)
  (add-hook 'python-mode-hook 'jedi:setup)

  ;; Rope mode... see http://milkbox.net/note/installing-pymacs-rope-on-emacs-24/
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")

  (after 'flymake
    (message "configuring Python/flymake")
    ;; Flymake pylint
    (defun flymake-pylint-init ()
      (let* ((temp-file (flymake-init-create-temp-buffer-copy
                         'flymake-create-temp-inplace))
             (local-file (file-relative-name
                          temp-file
                          (file-name-directory buffer-file-name))))
                                        ; TODO(ben): incorporate --rcfile
        (let ((rcfile-args
               (if my-pylint-rcfile (list "--rcfile" my-pylint-rcfile) nil)))
          (cmd-in-virtualenv "epylint" (append
                                        (list local-file)
                                        rcfile-args
                                        )))))

    (setq-default my-python-virtualenv nil)
    (setq-default my-pylint-rcfile nil)

    (defun cmd-in-virtualenv (cmd args)
      (if (eq my-python-virtualenv nil)
          (list cmd args)
        (let ((zshargs (append
                        (list "source" (concat "$WORKON_HOME/" my-python-virtualenv "/bin/activate;"))
                        (list cmd)
                        args)))
          (list "zsh" (list "-c" (mapconcat 'identity zshargs " "))))))

    (add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pylint-init))

    (add-hook 'python-mode-hook 'my-setup-python)

    (defun my-setup-python ()
      (add-hook 'before-save-hook 'delete-trailing-whitespace 't 't)
      (flymake-mode 1))))

(after 'ropemacs
  ; conflicts with my help shortcut and I don't use it anyway
  (define-key ropemacs-local-keymap (kbd "M-?") nil))
