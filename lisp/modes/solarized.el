;;; TODO: make these part of customize or figure out how they can interact with Solarized well
(defun reset-modeline-styles ()
  (let ((fg (face-attribute 'default :background)))
    (set-face-attribute 'mode-line nil :background "#c60007" :foreground fg)
    (set-face-attribute 'powerline-active1 nil :background "#268bd2" :foreground fg)
    (set-face-attribute 'powerline-active2 nil :background "#b58900" :foreground fg)
    (set-face-attribute 'mode-line-inactive nil :background "#465a61" :foreground fg)
    (set-face-attribute 'powerline-inactive1 nil :background "#708183" :foreground fg)
    (set-face-attribute 'powerline-inactive2 nil :background "#81908f" :foreground fg)
    (powerline-reset)))

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
