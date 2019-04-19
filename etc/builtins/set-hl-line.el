;;; set-hl-line.el ---  highlight current line mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; Triggers
(add-hook 'conf-mode-hook  #'hl-line-mode)
(add-hook 'dired-mode-hook #'hl-line-mode)
(add-hook 'prog-mode-hook  #'hl-line-mode)
(add-hook 'text-mode-hook  #'hl-line-mode)

;; Config
(with-eval-after-load 'hl-line
  (defun vs|hl-line/range ()
    (save-excursion
      (cons (progn (vertical-motion 0) (point))
            (progn (vertical-motion 1) (+ (point) 0))
            )
      )
    )

  (setq hl-line-range-function #'vs|hl-line/range
        hl-line-sticky-flag    nil)
  )

(provide 'set-hl-line)
;;; set-hl-line.el ends here
