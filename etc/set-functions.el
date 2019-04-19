;;; set-functions.el --- useful functions and macros. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(require 'set-config)

(defun vs|emacs/gui-frames-count ()
  "Return count of visible non-terminal frames.
Used by `emacsclient' wrapper only."
  (let ((count 0))
    (dolist (frame (visible-frame-list))
      (unless (string= (framep frame) "t")
        (setq count (1+ count))
        )
      )
    count
    )
  )

(defun vs|emacs/enable-startup-optimizations ()
  "Temporarily disable gc and `file-name-handler-alist' handlers."
  (setq gc-cons-threshold          most-positive-fixnum
        vs-file-name-handler-alist file-name-handler-alist
        file-name-handler-alist    nil)
  )

(defun vs|emacs/disable-startup-optimizations ()
  "Reset gc and `file-name-handler-alist' to reasonable defaults."
  (setq file-name-handler-alist    vs-file-name-handler-alist
        gc-cons-threshold          vs-gc-cons-threshold)
  )

(defun vs|emacs/add-subdirs-to-load-path (dir)
  "Recursively add DIR's subdirs to `load-path'."
  (let ((default-directory dir))
    (when (file-exists-p dir)
      (add-to-list 'load-path dir)
      (normal-top-level-add-subdirs-to-load-path)
      )
    )
  )

(defun vs|emacs/apply-for-each-file-in (dir func &optional regexp)
  "Apply for each file name in DIR function FUNC filtered by REGEXP."
  (when (file-exists-p dir)
    (require 'find-lisp)
    (mapc func (sort (find-lisp-find-files dir (or regexp "^.+$")) 'string<))
    )
  )

(defun vs|emacs/require-dir (dir)
  "Load all packages from DIR."
  (when (file-exists-p dir)
    (vs|emacs/apply-for-each-file-in dir (lambda (fname)
                                           (let ((feature (intern (file-name-base fname)))
                                                 (path (file-name-directory fname))
                                                 )
                                             (add-to-list 'load-path path)
                                             (require feature)
                                             )
                                           )
                                     "\\.el$")
    )
  )

(defun vs|emacs|byte-compile-init ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0)
  )

(defun vs|emacs/scale-color-limit (rgb value)
  "Calculate maximum difference VALUE for RGB channels."
  (unless (listp rgb)
    (error "Wrong type argument: listp, RGB")
    )
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= VALUE <= 1.0")
    )
  (let* ((r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb))
         (value-limit (if (> value 0) (- 1 (max r g b)) (min r g b)))
         )
    (* (if (< value 0) -1 1) (min value-limit (abs value)))
    )
  )

(defun vs|emacs/scale-color (color value)
  "Try to increase or decrease COLOR on VALUE."
  (unless (stringp color)
    (error "Wrong type argument: stringp, COLOR with format '#(abc|aabbcc|aaaabbbbcccc|color-name)'")
    )
  (unless (and (floatp value) (>= value -1.0) (<= value 1.0))
    (error "Wrong type argument: floatp, -1.0 <= VALUE <= 1.0")
    )
  (require 'color)
  (let* ((rgb (color-name-to-rgb color))
         (value (vs|emacs/scale-color-limit rgb value))
         (r (nth 0 rgb)) (g (nth 1 rgb)) (b (nth 2 rgb))
         )
    (color-rgb-to-hex (+ r value) (+ g value) (+ b value) 2)
    )
  )

(defun vs|emacs/scale-face-color (face-list factor &optional background)
  "Proportionally increase FACE-LIST foreground colors to FACTOR percents.
When BACKGROUND is t then scale background colors."
  (unless (listp face-list)
    (error "Wrong type argument: listp, FACE-LIST")
    )
  (unless (and (integerp factor)
               (and (>= factor -100) (<= factor 100)))
    (error "Wrong type argument: integerp, -100 <= FACTOR <= 100")
    )
  (let ((property    (if background :background :foreground))
        (value       (* 0.01 factor))
        (value-limit 1.0)
        )
    ;; Calculate value-limit for all faces
    (mapc
     (lambda (face)
       (let ((color (face-attribute face property)))
         (unless (string= color "unspecified")
           (setq value-limit (min value-limit
                                  (abs (vs|emacs/scale-color-limit (color-name-to-rgb color)
                                                                   value))))
           )
         )
       )
     face-list
     )
    ;; Choose between value and value-limit
    (setq value (* (if (< factor 0) -1 1) (min value-limit (abs value))))
    ;; Apply result to all faces
    (mapc
     (lambda (face)
       (let ((color (face-attribute face property)))
         (unless (string= color "unspecified")
           (set-face-attribute face nil property (vs|emacs/scale-color color value))
           )
         )
       )
     face-list
     )
    value ;; return actual scale value
    )
  )

(defun vs|emacs|apply-dir-locals ()
  "Apply directory local variables to buffer."
  (interactive)
  (let ((enable-dir-local-variables t   )
        (enable-local-variables     :all)
        )
    (hack-dir-local-variables-non-file-buffer)
    )
  )

(defun vs|emacs|smart-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))
      )
    )

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1)
      )
    )
  )

(defun vs|emacs|backward-delete-line ()
  "Backward delete line from point till beginning."
  (interactive)
  (delete-region (point)
                 (line-beginning-position))
  )

(defun vs|emacs/kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing)
      )
    )
  )

(defun vs|emacs|kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (vs|emacs/kill-thing-at-point 'word)
  )

(defun vs|emacs|delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point)))
  )

(defun vs|emacs|backward-delete-word (arg)
  "Delete characters backward until encountering the end of a word.
With ARG, do this that many times."
  (interactive "p")
  (vs|emacs|delete-word (- arg))
  )

(defun vs|emacs/get-my-ip ()
  "Obtain own external IP address."
  (interactive)
  (message "IP: %s"
           (with-current-buffer (url-retrieve-synchronously "https://api.ipify.org")
             (buffer-substring (+ 1 url-http-end-of-headers) (point-max))
             )
           )
  )

(provide 'set-functions)
;;; set-functions.el ends here
