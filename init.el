(add-to-list 'load-path "~/.emacs.d/lisp")

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
 '(org-agenda-files nil)
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

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; server
(add-hook 'after-init-hook
          (lambda ()
            (progn
              (server-start)
              (require 'edit-server)
              (message "starting edit server...")
              (edit-server-start)
              (require 'yasnippet)
              (message "yas-global-mode...")
              (yas-global-mode 1)
              )))

(message "init succeeded!")

