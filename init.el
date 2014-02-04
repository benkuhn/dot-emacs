(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)

;;; Solarized is pretty
(load-theme 'solarized-dark t)

(mapc 'load-library
      '("funcs"
        "keys"
        "modes"
        "my-config"
        ))

;;; customizations
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
 '(completion-ignored-extensions dired-omit-extensions)
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
 '(inhibit-startup-echo-area-message "bkuhn")
 '(isearch-allow-scroll t)
 '(lyqi:midi-backend (quote alsa))
 '(lyqi:prefered-languages (quote (english)))
 '(make-backup-files nil)
 '(org-modules (quote (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-rmail org-w3m)))
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
 '(font-latex-sectioning-0-face ((t (:inherit font-latex-sectioning-5-face :background "pale turquoise"))) t)
 '(font-latex-sectioning-1-face ((t (:inherit font-latex-sectioning-5-face :underline t :slant italic))) t)
 '(font-latex-sectioning-2-face ((t (:inherit font-latex-sectioning-5-face :underline t))) t)
 '(font-latex-sectioning-3-face ((t (:inherit font-latex-sectioning-5-face :slant italic))) t)
 '(font-latex-sectioning-4-face ((t (:inherit font-latex-sectioning-5-face))) t)
 '(font-latex-sectioning-5-face ((t (:foreground "blue4" :weight bold))) t)
 '(linum ((t (:inherit (shadow default) :background "#002b36" :foreground "#839496" :height 80))))
 '(mode-line ((t (:background "#93a1a1" :foreground "#073642" :inverse-video nil :box nil :underline nil :slant normal :weight normal))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#586e75" :foreground "#073642" :inverse-video nil :box nil :underline nil :slant normal :weight normal))))
 '(powerline-active1 ((t (:inherit mode-line :background "#657b83"))))
 '(powerline-active2 ((t (:inherit mode-line :background "#073642" :foreground "#93a1a1"))))
 '(powerline-inactive1 ((t (:inherit mode-line-inactive :background "#073642" :foreground "#93a1a1"))))
 '(powerline-inactive2 ((t (:inherit mode-line-inactive :background "#002b36" :foreground "#93a1a1")))))

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
