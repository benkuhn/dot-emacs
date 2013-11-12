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
