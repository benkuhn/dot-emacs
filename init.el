;;; nice keybindings
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-h" 'backward-delete-char)
(global-set-key (kbd "\C-x r S") 'string-insert-rectangle)
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))
(global-set-key "\C-a" 'smart-beginning-of-line)
(global-set-key [home] 'smart-beginning-of-line)
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards)

;;; GUI is evil
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;;; make eshell notify after long commands
;; (setq eshell-notification-wait 5)
;; (setq nneshell-prompt-function
;;       (lambda nil
;;         (let ((curtime (float-time)))
;;           (if (and (boundp 'eshell-last-command)
;;                    (> curtime (+ eshell-last-command-time
;;                                  eshell-notification-wait)))
;;               (notify "Command finished" eshell-last-command)))
;;         (concat (eshell/pwd) " $ ")))
;; (add-hook 'eshell-named-command-hook 'eshell-timed-command)
;; (defun princ-to-string (obj)
;;   (with-output-to-string
;;     (princ obj)))
;; (defun eshell-timed-command (&rest words)
;;   (unless (boundp 'eshell-last-command)
;;     (make-local-variable 'eshell-last-command)
;;     (make-local-variable 'eshell-last-command-time))
;;   (setq eshell-last-command-time (float-time))
;;   (setq eshell-last-command "wibble")
;;   (setq eshell-last-command (combine-and-quote-strings
;;                              (mapcar 'princ-to-string words)))
;;   nil)

;;; different apps


;;; bells and whistles
(iswitchb-mode)
(desktop-save-mode 1)
;(setq mouse-autoselect-window t)
;;; YASnippet
(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")
(yas/load-directory "~/.emacs.d/snippets/")
;;;
;(add-to-list 'load-path "~/.emacs.d/plugins/misc")
;(autoload 'notify "notify" "Notify TITLE, BODY.")
;;; haskell mode
(add-to-list 'load-path "~/.emacs.d/plugins/haskell-mode")
(load "~/.emacs.d/plugins/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;;; Tuareg mode (OCaml)
(add-to-list 'load-path "~/.emacs.d/plugins/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t)
;;; this is broken for me
;;(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
;;; CoffeeScript
(add-to-list 'load-path "~/.emacs.d/plugins/coffee-mode")
(require 'coffee-mode)
;;2-space tabs
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom)))

;;; for LaTeX: auto-refresh PDF buffers
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq inhibit-startup-message t)
(put 'narrow-to-region 'disabled nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(server-start)

;;; make C mode nicer
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq cs50-c-style
  '((c-offsets-alist . ((substatement-open . 0) (case-label . +)))))
(add-hook 'c-mode-common-hook
  '(lambda ()
     (c-toggle-hungry-state 1)
     (c-add-style "cs50" cs50-c-style)))
(set-variable 'c-default-style "cs50")

;;; stored usernames/passwords
(setq auth-sources '((:source "~/.authinfo" :host t :protocol t)))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Documents/org/classes.org")))
 '(warning-minimum-level :error))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

(load "~/.emacs.d/plugins/nxhtml/autostart.el")
;; HTML5
(add-to-list 'load-path "~/.emacs.d/plugins/html5-el/")
(eval-after-load "rng-loc"
  '(add-to-list 'rng-schema-locating-files "~/.emacs.d/plugins/html5-el/schemas.xml"))
(require 'whattf-dt)

;;; function to rotate a list of strings
(defun permute-strings (args)
  (interactive (list (get-permute-args 1)))
  (save-excursion
    (save-restriction
      (narrow-to-region (point) (mark))
      (beginning-of-buffer)
      (replace-string (car args) "__TMP__")
      (let ((end (permute-strings-helper args)))
        (beginning-of-buffer)
        (replace-string "__TMP__" end)))))

(defun permute-strings-helper (args)
  (if (cadr args)
      (progn
        (beginning-of-buffer)
        (replace-string (cadr args) (car args))
        (permute-strings-helper (cdr args)))
    (car args)))

(defun get-permute-args (num)
  (let ((arg (read-string "String to permute: " nil 'my-history)))
    (if (string= arg "")
        nil
      (cons arg (get-permute-args (+ num 1))))))