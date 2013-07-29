;;; nice keybindings
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-xk" 'kill-this-buffer)
(global-set-key "\C-x\C-k" 'kill-region)
(define-key key-translation-map "\C-h" "\C-?")
(global-set-key (kbd "C-?") 'help-command)
(global-set-key "\C-c\C-r" 'replace-string)
(global-set-key "\C-c\C-e" 'replace-regexp)
(global-set-key "\C-x\C-r" 'recentf-open-files)
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
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))
(global-set-key "\M-Y" 'yank-pop-forwards)

;;; GUI is evil
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(column-number-mode 1)

;; (require 'smooth-scrolling)
(require 'linum)
(global-linum-mode)

(add-hook 'text-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook
          (lambda ()
            (linum-mode -1)))

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

;;; bells and whistles
(ido-mode)
(desktop-save-mode 1)

;;; nicer filenames
(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")
(show-paren-mode 1)

;;; recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 100)

;(setq mouse-autoselect-window t)

;;; nicer dired
(add-hook 'dired-mode-hook
          (function (lambda ()
                      (require 'dired-x)
                      (dired-omit-mode 1)
                      )))
(setq dired-guess-shell-alist-default nil)
;; Don't show junk in dired
(setq dired-omit-extensions
      '(
        "#" ".DS_Store" ".a" ".annot" ".aux" ".bbl" ".bbl" ".blg"
        ".blg" ".brf" ".byte" ".class" ".cma" ".cmi" ".cmo" ".cmt"
        ".cmti" ".cmx" ".cmxa" ".deps" ".dvi" ".elc" ".glo" ".glob"
        ".gls" ".hc" ".hi" ".hp" ".hva" ".idx" ".ilg" ".ind" ".ist"
        ".libdeps" ".lo" ".loa" ".loe" ".lof" ".lot" ".ml.d" ".mli.d"
        ".native" ".nav" ".o" ".objdeps" ".omc" ".pdfsync" ".rel"
        ".snm" ".so" ".spit" ".spot" ".synctex.gz" ".toc" ".v.d" ".vo"
        ".vrb" "~" "hgignore.in" ".build_info.c" ".hg_version.c"
        ))

;;; kill unused buffers
(require 'midnight)
(midnight-delay-set 'midnight-delay "4:30am")
(setq clean-buffer-list-delay-general 10)

;;;
;(add-to-list 'load-path "~/.emacs.d/plugins/misc")
;(autoload 'notify "notify" "Notify TITLE, BODY.")

;;; SCSS mode
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/scss-mode"))
;; (autoload 'scss-mode "scss-mode")
;; (add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; markdown-mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

;;2-space tabs
(defun coffee-custom ()
  "hook run for coffee-mode"
  (local-set-key "\C-j" 'coffee-newline-and-indent))
(add-hook 'coffee-mode-hook 'coffee-custom)
;;; LilyPond
;; (add-to-list 'load-path "~/.emacs.d/plugins/lilypond-mode/")
;; (autoload 'LilyPond-mode "lilypond-mode" "LilyPond Editing Mode" t)
;; (add-to-list 'auto-mode-alist '("\\.ly$" . LilyPond-mode))
;; (add-to-list 'auto-mode-alist '("\\.ily$" . LilyPond-mode))
;; (add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))

;;; for LaTeX: auto-refresh PDF buffers
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
(setq inhibit-startup-message t)
(put 'narrow-to-region 'disabled nil)
(defalias 'yes-or-no-p 'y-or-n-p)
(server-start)

;;; make C mode nicer
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq cs50-c-style
  '((c-offsets-alist . ((substatement-open . 0) (case-label . +)))))
(add-hook 'c-mode-common-hook
  '(lambda ()
     (c-toggle-hungry-state 1)
     (c-add-style "cs50" cs50-c-style)))
(set-variable 'c-default-style "cs50")

;;; w3m customizations
(setq w3m-default-display-inline-images t)

;;; stored usernames/passwords
(setq auth-sources '((:source "~/.authinfo" :host t :protocol t)))

;;; customizations
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LilyPond-command-alist (quote (("LilyPond" "lilypond %s" "%s" "%l" "View") ("2PS" "lilypond -f ps %s" "%s" "%p" "ViewPS") ("2Gnome" "lilypond -b gnome %s") ("Book" "lilypond-book %x" "%x" "%l" "LaTeX") ("LaTeX" "latex '\\nonstopmode\\input %l'" "%l" "%d" "ViewDVI") ("View" "xdg-open %f") ("ViewPDF" "xdg-open %f") ("ViewPS" "gv --watch %p") ("Midi" "") ("MidiAll" ""))))
 '(TeX-PDF-mode t)
 '(ansi-term-color-vector [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268BD2" "#d33682" "#00877C" "#002b36"])
 '(auto-save-default nil)
 '(coffee-tab-width 2)
 '(completion-ignored-extensions dired-omit-extensions)
 '(custom-safe-themes (quote ("085b401decc10018d8ed2572f65c5ba96864486062c0a2391372223294f89460" "21d9280256d9d3cf79cbcf62c3e7f3f243209e6251b215aede5026e0c5ad853f" "72cc9ae08503b8e977801c6d6ec17043b55313cda34bcf0e6921f2f04cf2da56" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "d2622a2a2966905a5237b54f35996ca6fda2f79a9253d44793cfe31079e3c92b" "501caa208affa1145ccbb4b74b6cd66c3091e41c5bb66c677feda9def5eab19c" "30fe7e72186c728bd7c3e1b8d67bc10b846119c45a0f35c972ed427c45bacc19" "71efabb175ea1cf5c9768f10dad62bb2606f41d110152f4ace675325d28df8bd" "fe6330ecf168de137bb5eddbf9faae1ec123787b5489c14fa5fa627de1d9f82b" "71b172ea4aad108801421cc5251edb6c792f3adbaecfa1c52e94e3d99634dee7" default)))
 '(desktop-restore-eager 15)
 '(dired-enable-local-variables nil)
 '(dired-guess-shell-alist-user (list (list "\\.tar.bz2\\'" "tar -xjf" "bunzip2") (list "\\.tar.gz\\'" "tar -xzf" "gunzip") (list "\\.bz2\\'" "bunzip2") (list "\\.bzip\\'" "bunzip2") (list "\\.dvi\\'" "dvi2pdf") (list "\\.gz\\'" "gunzip") (list "\\.pdf\\'" "acroread") (list "\\.ps\\'" "ps2pdf") (list "\\.tar\\'" "tar -xf") (list "\\.tbz\\'" "tar -xjf") (list "\\.tgz\\'" "tar -xzf" "gunzip") (list "\\.Z\\'" "unzip") (list "\\.zip\\'" "unzip")))
 '(dired-omit-files "^\\..*$")
 '(dired-omit-size-limit nil)
 '(dired-recursive-copies (quote always))
 '(dired-recursive-deletes (quote top))
 '(fci-rule-color "#383838")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#F2F2F2" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#6DA8D2" . 50) ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85) ("#F2F2F2" . 100))))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(isearch-allow-scroll t)
 '(lyqi:midi-backend (quote alsa))
 '(lyqi:prefered-languages (quote (english)))
 '(make-backup-files nil)
 '(org-agenda-files (quote ("~/Documents/org/classes.org")))
 '(safe-local-variable-values (quote ((default-tab-width 8) (tab-width 8))))
 '(set-mark-command-repeat-pop t)
 '(smooth-scroll-margin 10)
 '(tab-width 2)
 '(warning-minimum-level :error))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "microsoft" :family "Consolas"))))
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-5-face :background "pale turquoise"))))
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-5-face :underline t :slant italic))))
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-5-face :underline t))))
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-5-face :slant italic))))
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))))
 '(font-latex-sectioning-5-face ((t (:foreground "blue4" :weight bold)))))

(defun my-desktop-save ()
  (interactive)
  ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

;; (load "~/.emacs.d/plugins/nxhtml/autostart.el")
;; HTML5
;; (add-to-list 'load-path "~/.emacs.d/plugins/html5-el/")
;; (eval-after-load "rng-loc"
;;   '(add-to-list 'rng-schema-locating-files "~/.emacs.d/plugins/html5-el/schemas.xml"))
;; (require 'whattf-dt)

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

;; Enable directory local variables with remote files. This facilitates both
;; the (dir-locals-set-class-variables ...)(dir-locals-set-directory-class ...)
;; and the dir-locals.el approaches.
(defadvice hack-dir-local-variables (around my-remote-dir-local-variables)
  "Allow directory local variables with remote files, by temporarily redefining
     `file-remote-p' to return nil unconditionally."
  (flet ((file-remote-p (&rest) nil))
    ad-do-it))
(ad-activate 'hack-dir-local-variables)

(add-hook 'after-init-hook
  (lambda ()
    (yas-global-mode 1)
    ;;; moar packages
    (add-to-list 'package-archives 
      '("marmalade" . "http://marmalade-repo.org/packages/"))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
