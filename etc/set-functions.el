;;; set-functions.el --- useful functions and macros. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(defun vs|emacs/add-subdirs-to-load-path (dir)
  "Recursively add DIR's subdirs to `load-path'."
  (let ((default-directory dir))
    (when (file-exists-p dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path))))


(defun vs|emacs/apply-for-each-file-in (dir func &optional regexp)
  "Apply for each file name in DIR function FUNC filtered by REGEXP."
  (when (file-exists-p dir)
    (require 'find-lisp)
    (mapc func (sort (find-lisp-find-files dir (or regexp "^.+$")) 'string<))))


(defun vs|emacs/require-dir (dir)
  "Load all packages from DIR."
  (when (file-exists-p dir)
    (vs|emacs/apply-for-each-file-in dir (lambda (fname)
                                           (let ((feature (intern (file-name-base fname)))
                                                 (path (file-name-directory fname)))
                                             (add-to-list 'load-path path)
                                             (require feature)))
                                     "\\.el$")))


(defun vs|emacs/byte-compile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (byte-recompile-directory vs-emacs-home-dir 0))


(defun vs|emacs/scale-color-limit (rgb value)
  "Calculate maximum difference VALUE for RGB channels."
  (unless (listp rgb)
    (error "Wrong type argument: listp, RGB"))
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= VALUE <= 1.0"))
  (let* ((r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb))
         (value-limit (if (> value 0) (- 1 (max r g b)) (min r g b))))
    (* (if (< value 0) -1 1) (min value-limit (abs value)))))


(defun vs|emacs/scale-color (color value)
  "Try to increase or decrease COLOR on VALUE."
  (unless (stringp color)
    (error "Wrong type argument: stringp, COLOR with format '#(abc|aabbcc|aaaabbbbcccc|color-name)'"))
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= VALUE <= 1.0"))
  (let* ((rgb (color-name-to-rgb color))
         (value (vs|emacs/scale-color-limit rgb value))
         (r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb)))
    (color-rgb-to-hex (+ r value) (+ g value) (+ b value) 2)))


(defun vs|emacs/scale-face-color (face-list factor &optional background)
  "Proportionally increase FACE-LIST foreground colors to FACTOR percents.
When BACKGROUND is t then scale background colors."
  (unless (listp face-list)
    (error "Wrong type argument: listp, FACE-LIST"))
  (unless (and (integerp factor)
               (and (>= factor -100) (<= factor 100)))
    (error "Wrong type argument: integerp, -100 <= FACTOR <= 100"))
  (let ((property    (if background :background :foreground))
        (value       (* 0.01 factor))
        (value-limit 1.0))
    ;; Calculate value-limit for all faces
    (mapc
     (lambda (face)
       (let ((color (face-attribute face property)))
         (unless (string= color "unspecified")
           (setq value-limit (min value-limit
                                  (abs (vs|emacs/scale-color-limit (color-name-to-rgb color)
                                                                   value)))))))
     face-list)
    ;; Choose between value and value-limit
    (setq value (* (if (< factor 0) -1 1) (min value-limit (abs value))))
    ;; Apply result to all faces
    (mapc
     (lambda (face)
       (let ((color (face-attribute face property)))
         (unless (string= color "unspecified")
           (set-face-attribute face nil property (vs|emacs/scale-color color value)))))
     face-list)
    ;; Return actula scale value
    value))


(defadvice vs|emacs/exchange-point-and-mark (before deactivate-mark activate compile)
  "When called with no active region, do not activate mark."
  (interactive
   (list (not (region-active-p)))))


(defun vs|emacs|apply-dir-locals ()
  "Apply directory local variables to buffer."
  (interactive)
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))


(provide 'set-functions)
;;; set-functions.el ends here
