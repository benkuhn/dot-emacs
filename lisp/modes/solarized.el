;;; TODO: make these part of customize or figure out how they can
;;; interact with Solarized well

(load-theme 'ben-solarized-dark t)

;(load-theme 'solarized-light t t)
;(load-theme 'solarized-dark t)

(require 'powerline)
(powerline-default-theme)

;;; TODO: make this work on non-Macs; right now it just blindly uses
;;; Gen RGB from solarized source
(setq my-solarized-yellow  "#a57705")
(setq my-solarized-orange  "#bd3612")
(setq my-solarized-red     "#c60007")
(setq my-solarized-magenta "#c61b6e")
(setq my-solarized-violet  "#5859b7")
(setq my-solarized-blue    "#2075c7")
(setq my-solarized-cyan    "#259185")
(setq my-solarized-green   "#728a05")
(setq my-solarized-base03  "#042028")
(setq my-solarized-base02  "#0a2832")
(setq my-solarized-base01  "#465a61")
(setq my-solarized-base00  "#52676f")
(setq my-solarized-base0   "#708183")
(setq my-solarized-base1   "#81908f")
(setq my-solarized-base2   "#e9e2cb")
(setq my-solarized-base3   "#fcf4dc")

(defface bsk/eshell-dir 
  `((t :foreground ,my-solarized-base02
       :background ,my-solarized-blue
       :weight bold
       :inherit 'default))
  "Face in which my eshell prompt prints the directory."
  :group 'bsk-eshell-prompt)

(defun reset-modeline-styles ()
  (interactive)
  (let ((fg  (face-attribute 'default :background))
        (fg2 (face-attribute 'default :foreground)))
    (set-face-attribute 'mode-line nil           :background my-solarized-yellow :foreground fg)
    (set-face-attribute 'powerline-active1 nil   :background my-solarized-blue   :foreground fg)
    (set-face-attribute 'powerline-active2 nil   :background my-solarized-base02 :foreground fg2)
    (set-face-attribute 'mode-line-inactive nil  :background my-solarized-base02 :foreground fg2)
    (set-face-attribute 'powerline-inactive1 nil :background my-solarized-base03 :foreground fg2)
    (set-face-attribute 'powerline-inactive2 nil :background my-solarized-base03 :foreground my-solarized-base0)
    (powerline-reset)
    nil))

(setq powerline-default-separator 'utf-8)

(reset-modeline-styles)

(defun toggle-solarized-theme ()
  (interactive)
  (if (member 'solarized-dark custom-enabled-themes)
      (progn
        (disable-theme 'solarized-dark)
        (enable-theme 'solarized-light))
    (progn
      (disable-theme 'solarized-light)
      (enable-theme 'solarized-dark)))
  (reset-modeline-styles))
