;;; make C mode nicer
(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 4)
(setq cs50-c-style
  '((c-offsets-alist . ((substatement-open . 0) (case-label . +)))))
(add-hook 'c-mode-common-hook
  '(lambda ()
     (c-toggle-hungry-state 1)
     (c-add-style "cs50" cs50-c-style)))
(set-variable 'c-default-style "cs50")
