;;; set-functions.el --- useful functions and macros. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
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
  (byte-recompile-directory vs-emacs-home-dir 0))


(defun vs::color::scale-limit (rgb value)
  "Calculate maximum available difference of '(R G B) channels."
  (unless (listp rgb)
    (error "Wrong type argument: listp, `RGB'"))
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= `VALUE' <= 1.0"))
  (let* ((r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb))
         (value-limit (if (> value 0) (- 1 (max r g b)) (min r g b))))
    (* (if (< value 0) -1 1) (min value-limit (abs value)))))


(defun vs::color::scale (color value)
  "Try to increase or decrease `COLOR' saturation on `VALUE'."
  (unless (stringp color)
    (error "Wrong type argument: stringp, `COLOR' with format '#(abc|aabbcc|aaaabbbbcccc|color-name)'"))
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= `VALUE' <= 1.0"))
  (let* ((rgb (color-name-to-rgb color))
         (value (vs::color::scale-limit rgb value))
         (r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb)))
    (color-rgb-to-hex (+ r value) (+ g value) (+ b value) 2)))


(defun vs::face::scale-color (face-list factor)
  "Increase `FACE-LIST' background and foreground color saturation to `FACTOR' percents."
  (unless (listp face-list)
    (error "Wrong type argument: listp, `FACE-LIST'"))
  (unless (and (integerp factor)
               (and (>= factor -100) (<= factor 100)))
    (error "Wrong type argument: integerp, -100 <= `FACTOR' <= 100"))
  (let ((value (* 0.01 factor))
        (value-limit 1.0))
    (mapc
     (lambda (face)
       (let ((bg (face-attribute face :background))
             (fg (face-attribute face :foreground)))
         ;;(message "background: '%s', foreground: '%s'" bg fg)
         (unless (string= bg "unspecified")
           (let ((rgb (color-name-to-rgb bg)))
             (setq value-limit (min value-limit
                                    (abs (vs::color::scale-limit rgb value))))))
         (unless (string= fg "unspecified")
           (let ((rgb (color-name-to-rgb fg)))
             (setq valie-limit (min value-limit
                                    (abs (vs::color::scale-limit rgb value))))))))
     face-list)
    ;;(message "scale value: '%f', scale value limit: '%f'" value value-limit)
    (setq value (* (if (< factor 0) -1 1) (min value value-limit)))
    ;;(message "calculated scale value: '%f' for factor: '%d'" value factor)
    (mapc
     (lambda (face)
       (let ((bg (face-attribute face :background))
             (fg (face-attribute face :foreground)))
         (unless (string= bg "unspecified")
           (set-face-attribute face nil :background (vs::color::scale bg value)))
         (unless (string= fg "unspecified")
           (set-face-attribute face nil :foreground (vs::color::scale fg value)))))
     face-list)
    value))


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
