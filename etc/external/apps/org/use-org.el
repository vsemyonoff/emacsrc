;;; use-org.el --- Org mode. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(use-package org :straight org-plus-contrib
  :mode ("\\.org$" . org-mode    )
  :hook (org-mode  . vs:org/setup)
  :init
  (defun vs:org/setup ()
    (setq-local cursor-type       'bar)
    (setq-local show-paren-mode    nil)
    (setq-local system-time-locale "C")

    (variable-pitch-mode)
    (visual-line-mode   )
    (hl-line-mode     -1)
    (whitespace-mode  -1)
    )

  (with-eval-after-load 'org-indent
    (custom-theme-set-faces
     'user
     '(org-block                 ((t (:inherit (shadow fixed-pitch)))))
     '(org-checkbox              ((t (:inherit (bold fixed-pitch)))))
     '(org-code                  ((t (:inherit (shadow fixed-pitch)))))
     '(org-date                  ((t (:inherit fixed-pitch))))
     '(org-document-info-keyword ((t (:inherit (shadow fixed-pitch)))))
     '(org-done                  ((t (:inherit fixed-pitch))))
     '(org-formula               ((t (:inherit fixed-pitch))))
     '(org-block-begin-line      ((t (:inherit org-meta-line))))
     '(org-block-end-line        ((t (:inherit org-block-begin-line))))
     '(org-indent                ((t (:inherit (org-hide fixed-pitch)))))
     '(org-meta-line             ((t (:inherit (font-lock-comment-face fixed-pitch)))))
     '(org-property-value        ((t (:inherit fixed-pitch))))
     '(org-special-keyword       ((t (:inherit (font-lock-keyword-face fixed-pitch)))))
     '(org-table                 ((t (:inherit fixed-pitch))))
     '(org-tag                   ((t (:inherit (shadow fixed-pitch) :weight bold :height 0.8))))
     '(org-todo                  ((t (:inherit fixed-pitch))))
     '(org-verbatim              ((t (:inherit (shadow fixed-pitch)))))
     )
    )

  :config
  (setq org-ellipsis              "▼"
        org-cycle-separator-lines -1
        org-hide-emphasis-markers  t
        org-src-fontify-natively   t
        org-src-tab-acts-natively  t
        org-startup-indented       t
        org-tags-column            0
        outline-blank-line         t
        )
  )

(use-feature org-compat
  :after org)

(provide 'use-org)
;;; use-org.el ends here
