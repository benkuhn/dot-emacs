;;; Helm/Projectile
(require 'helm)
(require 'helm-projectile)
(require 'helm-gtags)
(require 'projectile)
(helm-mode 1)
(projectile-global-mode 1)
(helm-projectile-on)

(defun maybe-gtags-mode ()
  (when (locate-dominating-file default-directory "GTAGS")
    ;(ggtags-mode)
    (helm-gtags-mode)))

(add-hook 'python-mode-hook 'maybe-gtags-mode)
