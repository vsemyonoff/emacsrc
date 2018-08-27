;;; set-functions.el --- useful functions and macros. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
;(require 'find-lisp)

(defun vs//add-subdirs-to-load-path (dir)
  "Recursively add DIR's subdirs to `load-path'."
  (let ((default-directory dir))
    (when (file-exists-p dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path))))

(defun vs//apply-for-each-file-in (dir func &optional regexp)
  "Apply for each file name in DIR function FUNC filtered by REGEXP."
  (when (file-exists-p dir)
    (require 'find-lisp)
    (mapc func (sort (find-lisp-find-files dir (or regexp "^.+$")) 'string<))))

(defun vs//require-dir (dir)
  "Load all packages from DIR."
  (when (file-exists-p dir)
    (vs//apply-for-each-file-in dir (lambda (fname)
                                      (let ((feature (intern (file-name-base fname)))
                                            (path (file-name-directory fname)))
                                        (add-to-list 'load-path path)
                                        (require feature)))
                                "\\.el$")))
(defun vs/byte-compile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (byte-recompile-directory vs-config-dir 0))

(defadvice exchange-point-and-mark (before deactivate-mark activate compile)
  "When called with no active region, do not activate mark."
  (interactive
   (list (not (region-active-p)))))

(defmacro with-region-or-buffer (func)
  "When called with no active region, call FUNC on current buffer."
  `(defadvice ,func (before with-region-or-buffer activate compile)
     (interactive
      (if mark-active
          (list (region-beginning) (region-end))
        (list (point-min) (point-max))))))

(provide 'set-functions)
;;; set-functions.el ends here
