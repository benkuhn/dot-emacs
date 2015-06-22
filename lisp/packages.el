;; My list of packages. NOTE: probably out of date.

(setq my-packages '(auctex coffee-mode
      color-theme csharp-mode dart-mode diminish edit-server ess
      f dash s flycheck pkg-info epl dash ggtags go-mode ham-mode
      markdown-mode html-to-markdown haskell-mode helm-gtags helm
      async helm-projectile projectile pkg-info epl dash s helm
      async html-to-markdown ido-ubiquitous jedi
      python-environment deferred auto-complete popup epc ctable
      concurrent deferred late-night-theme ledger-mode
      lorem-ipsum magit git-rebase-mode git-commit-mode
      markdown-mode monokai-theme multiple-cursors offlineimap
      pastels-on-dark-theme php-mode popup powerline projectile
      pkg-info epl dash s pymacs python-environment deferred
      rich-minority s sass-mode haml-mode smooth-scrolling
      stylus-mode sws-mode sws-mode tuareg caml undo-tree
      yasnippet))

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))

