;;; set-dired.el ---  dired mode settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(with-eval-after-load 'dired
  (require 'dired-x)

  (setq dired-dwim-target       t
        dired-listing-switches  "--group-directories-first -Alh"
        dired-omit-files        (concat dired-omit-files "\\|^\\..+$")
        dired-recursive-copies  'always
        dired-recursive-deletes 'top)

  ;; Enable reuse dir
  (put 'dired-find-alternate-file 'disabled nil)
  ;; Do not show hidden files
  (add-hook 'dired-mode-hook #'dired-omit-mode)

  (defun vs:dired/toggle (arg)
    (save-restriction
      (narrow-to-region (point-at-bol) (point-at-eol))
      (dired-toggle-marks)
      )
    (dired-previous-line arg)
    )

  (defun vs:dired|mark-up ()
    (interactive)
    (vs:dired/toggle 1)
    )

  (defun vs:dired|mark-down ()
    (interactive)
    (vs:dired/toggle -1)
    )

  (define-key dired-mode-map (kbd "<right>")  #'dired-find-alternate-file)
  (define-key dired-mode-map (kbd "<S-up>")   #'vs:dired|mark-up)
  (define-key dired-mode-map (kbd "<S-down>") #'vs:dired|mark-down)
  )

(provide 'set-dired)
;;; set-dired.el ends here
