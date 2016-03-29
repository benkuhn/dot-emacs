(after 'flycheck
  (message "configuring flycheck...")
  (define-key flycheck-mode-map (kbd "M-n") 'my-flycheck-next)
  (define-key flycheck-mode-map (kbd "M-p") 'my-flycheck-prev)
  )

(defun my-flycheck-next ()
  (interactive)
  (flycheck-next-error)
  (flycheck-display-error-at-point))

(defun my-flycheck-prev ()
  (interactive)
  (flycheck-previous-error)
  (flycheck-display-error-at-point))
