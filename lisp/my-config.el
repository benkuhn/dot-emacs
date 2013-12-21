;;; GUI is evil
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'blink-cursor-mode) (blink-cursor-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(column-number-mode 1)
(show-paren-mode 1)
(setq disabled-command-function nil)
(setq inhibit-startup-message t)
(defalias 'yes-or-no-p 'y-or-n-p)
