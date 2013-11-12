(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive "^")
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename n(buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))
(defun yank-pop-forwards (arg)
  (interactive "p")
  (yank-pop (- arg)))

;;; function to rotate a list of strings
(defun permute-strings (args)
  (interactive (list (get-permute-args 1)))
  (save-excursion
    (save-restriction
      (narrow-to-region (point) (mark))
      (beginning-of-buffer)
      (replace-string (car args) "__TMP__")
      (let ((end (permute-strings-helper args)))
        (beginning-of-buffer)
        (replace-string "__TMP__" end)))))

(defun permute-strings-helper (args)
  (if (cadr args)
      (progn
        (beginning-of-buffer)
        (replace-string (cadr args) (car args))
        (permute-strings-helper (cdr args)))
    (car args)))

(defun get-permute-args (num)
  (let ((arg (read-string "String to permute: " nil 'my-history)))
    (if (string= arg "")
        nil
      (cons arg (get-permute-args (+ num 1))))))

