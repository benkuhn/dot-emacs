;;; Helm/Projectile
(require 'helm)
(require 'helm-projectile)
(require 'helm-gtags)
(require 'projectile)
(helm-mode 1)
(projectile-global-mode 1)
(helm-projectile-on)

(after 'ggtags
  (message "configuring ggtags...")
  (setq ggtags-mode-line-project-name nil))

(defun maybe-gtags-mode ()
  (when (locate-dominating-file default-directory "GTAGS")
    (helm-gtags-mode)
    (ggtags-mode)
    (make-local-variable 'helm-projectile-sources-list)
    (setq helm-projectile-sources-list
          (append helm-projectile-sources-list '(helm-source-gtags-select)))))

(add-hook 'python-mode-hook 'maybe-gtags-mode)
