(defun zen-mode-on-enable ()
  (message "zen mode enabled")
  (window-configuration-to-register ?Z)
  (delete-other-windows)
  (set-fringe-style '(400 . 400))
  (if (eq major-mode 'org-mode)
      (org-narrow-to-subtree)
    (if mark-active
        (narrow-to-region (region-start) (region-end)))))

(defun zen-mode-on-disable ()
  (message "zen mode disabled")
  (let ((reg (get-register ?Z)))
    (if (and (consp reg)
             (window-configuration-p (car reg)))
        (progn
          (jump-to-register ?Z)
          (set-register ?Z nil))))
  (set-fringe-style)
  (widen))

(define-minor-mode zen-mode
  "A minor mode that makes Emacs less distracting."
  :lighter " zen"
  :global t
  (if zen-mode
      (zen-mode-on-enable)
    (zen-mode-on-disable)))
