(setq my-ly-mode-directory "/Applications/LilyPond.app/Contents/Resources/share/emacs/site-lisp")

(if (file-exists-p my-ly-mode-directory)
    (add-to-list 'load-path my-ly-mode-directory))

(autoload 'LilyPond-mode "lilypond-mode" "LilyPond Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.ly$" . LilyPond-mode))
(add-to-list 'auto-mode-alist '("\\.ily$" . LilyPond-mode))
(add-hook 'LilyPond-mode-hook (lambda () (turn-on-font-lock)))
