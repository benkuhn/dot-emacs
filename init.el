;;;; Set up packages

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

(message "setting custom variables...")

;;;; customizations
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LilyPond-command-alist (quote (("LilyPond" "lilypond %s" "%s" "%l" "View") ("2PS" "lilypond -f ps %s" "%s" "%p" "ViewPS") ("2Gnome" "lilypond -b gnome %s") ("Book" "lilypond-book %x" "%x" "%l" "LaTeX") ("LaTeX" "latex '\\nonstopmode\\input %l'" "%l" "%d" "ViewDVI") ("View" "xdg-open %f") ("ViewPDF" "xdg-open %f") ("ViewPS" "gv --watch %p") ("Midi" "") ("MidiAll" ""))))
 '(TeX-PDF-mode t)
 '(ansi-term-color-vector [unspecific "#586e75" "#dc322f" "#859900" "#b58900" "#268BD2" "#d33682" "#00877C" "#002b36"] t)
 '(auto-save-default nil)
 '(coffee-tab-width 2)
 '(custom-safe-themes (quote ("1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(desktop-restore-eager 15)
 '(dired-enable-local-variables nil)
 '(dired-guess-shell-alist-user (list (list "\\.tar.bz2\\'" "tar -xjf" "bunzip2") (list "\\.tar.gz\\'" "tar -xzf" "gunzip") (list "\\.bz2\\'" "bunzip2") (list "\\.bzip\\'" "bunzip2") (list "\\.dvi\\'" "dvi2pdf") (list "\\.gz\\'" "gunzip") (list "\\.pdf\\'" "acroread") (list "\\.ps\\'" "ps2pdf") (list "\\.tar\\'" "tar -xf") (list "\\.tbz\\'" "tar -xjf") (list "\\.tgz\\'" "tar -xzf" "gunzip") (list "\\.Z\\'" "unzip") (list "\\.zip\\'" "unzip")))
 '(dired-omit-files "^\\..*$")
 '(dired-omit-size-limit nil)
 '(dired-recursive-copies (quote always))
 '(dired-recursive-deletes (quote top))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(fci-rule-color "#383838")
 '(global-linum-mode t)
 '(global-undo-tree-mode t)
 '(helm-boring-buffer-regexp-list (quote ("\\` " "\\*helm" "\\*helm-mode" "\\*Echo Area" "\\*Minibuf" "\\*Pymacs" "\\*epc" "\\*magit-process\\*")))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-tail-colors (quote (("#F2F2F2" . 0) ("#B4C342" . 20) ("#69CABF" . 30) ("#6DA8D2" . 50) ("#DEB542" . 60) ("#F2804F" . 70) ("#F771AC" . 85) ("#F2F2F2" . 100))))
 '(ido-enable-flex-matching t)
 '(inhibit-startup-echo-area-message "bkuhn")
 '(isearch-allow-scroll t)
 '(linum-delay t)
 '(linum-eager nil)
 '(lyqi:midi-backend (quote alsa))
 '(lyqi:prefered-languages (quote (english)))
 '(make-backup-files nil)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
 '(projectile-mode-line (quote (:eval (format " (%s)" (projectile-project-name)))))
 '(require-final-newline t)
 '(safe-local-variable-values (quote ((flycheck-mode . t) (flycheck-pylintrc . "/Users/ben/code/thm/alpha/support/pylint/pylintrc") (eval setq-local compile-command (concat "/Users/ben/code/thm/unittest " buffer-file-name)) (flycheck-python-pylint-executable . "/Users/ben/code/thm/epylint"))))
 '(save-interprogram-paste-before-kill t)
 '(set-mark-command-repeat-pop t)
 '(smooth-scroll-margin 10)
 '(tab-width 2)
 '(warning-minimum-level :error)
 '(zen-mode nil))

(message "setting custom faces...")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-5-face :background "pale turquoise"))) t)
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-5-face :underline t :slant italic))) t)
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-5-face :underline t))) t)
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-5-face :slant italic))) t)
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))) t)
 '(font-latex-sectioning-5-face ((t (:weight bold))) t)
 '(helm-selection ((t (:inherit highlight :overline t :underline t))))
 '(helm-visible-mark ((t (:inherit region))))
 '(linum ((t (:height 80))))
 '(message-cited-text ((t (:foreground "#586e75"))) t)
 '(mode-line ((t (:background "#073642" :foreground "#93a1a1" :inverse-video nil :box nil :underline nil :slant normal :weight normal))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#002b36" :foreground "#93a1a1" :inverse-video nil :box nil :underline nil :slant normal :weight normal))))
 '(powerline-active1 ((t (:inherit mode-line :background "#657b83" :foreground "#073642"))))
 '(powerline-active2 ((t (:inherit mode-line :background "#93a1a1" :foreground "#073642"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "#073642" :foreground "#93a1a1"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "#073642" :foreground "#93a1a1"))))
 '(variable-pitch ((t (:family "Lucida Grande")))))

(message "forcing default face...")

;;; set the default font face outside Customize so that it sticks when the theme changes
(set-face-attribute 'default nil :family "Consolas")
(set-face-attribute 'default nil :height 110)

;; (load "~/.emacs.d/plugins/nxhtml/autostart.el")
;; HTML5
;; (add-to-list 'load-path "~/.emacs.d/plugins/html5-el/")
;; (eval-after-load "rng-loc"
;;   '(add-to-list 'rng-schema-locating-files "~/.emacs.d/plugins/html5-el/schemas.xml"))
;; (require 'whattf-dt)

;; Enable directory local variables with remote files. This facilitates both
;; the (dir-locals-set-class-variables ...)(dir-locals-set-directory-class ...)
;; and the dir-locals.el approaches.
;; (defadvice hack-dir-local-variables (around my-remote-dir-local-variables)
;;   "Allow directory local variables with remote files, by temporarily redefining
;;      `file-remote-p' to return nil unconditionally."
;;   (flet ((file-remote-p (&rest) nil))
;;     ad-do-it))
;; (ad-activate 'hack-dir-local-variables)

;;;; better eval-after-load for mode config
;; source: http://milkbox.net/note/single-file-master-emacs-configuration/

(defmacro after (mode &rest body)
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

(add-to-list 'load-path "~/.emacs.d/lisp")

;;; Solarized is pretty
(load-theme 'solarized-light t t)
(load-theme 'solarized-dark t)

(mapc #'(lambda (libname)
					(message "loading %s" libname)
					(load-library libname))
      '("funcs"
        "keys"
        "modes"
        "my-config"
        ))

;; not really sure why this doesn't autoload
;(load "ess-site")

(reset-modeline-styles)

;; server
(add-hook 'after-init-hook
          (defun my-set-up-server-and-yasnippet ()
            (server-start)
            (require 'edit-server)
            (message "starting edit server...")
            (edit-server-start)
            (require 'yasnippet)
            (message "yas-global-mode...")
            (yas-global-mode 1)))

(message "init succeeded!")
