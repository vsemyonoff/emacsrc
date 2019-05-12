;;; use-modeline.el ---  mode line settings. -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:
(if (not (straight-use-package 'telephone-line))
    (warn "===> Can't install 'telephone-line'")

  ;; Config
  (with-eval-after-load 'telephone-line

    ;; Custon segments
    (telephone-line-defsegment* vs|modeline/major-mode-segment ()
      (let ((recursive-edit-help-echo "Recursive edit, type C-M-c to get out"))
        `(
          (:propertize "%[" help-echo ,recursive-edit-help-echo face ,face)
          (:propertize ,(all-the-icons-icon-for-mode major-mode :v-adjust 0 :height 0.9)
                       help-echo "Major mode\n\
mouse-1: Display major mode menu\n\
mouse-2: Show help for major mode\n\
mouse-3: Toggle minor modes"
                       mouse-face mode-line-highlight
                       local-map ,mode-line-major-mode-keymap
                       )
          (:propertize "%]" help-echo ,recursive-edit-help-echo face ,face)
          )
        )
      )

    (telephone-line-defsegment vs|modeline/projectile-segment ()
      (if (fboundp 'projectile-project-name)
          (format "[%s]" (propertize (projectile-project-name)
                                     'display '(raise 0.0)
                                     'help-echo "Switch project"
                                     'local-map (make-mode-line-mouse-map
                                                 'mouse-1 (lambda ()
                                                            (interactive)
                                                            (projectile-switch-project)
                                                            )
                                                 )
                                     )
                  )
        )
      )

    (telephone-line-defsegment vs|modeline/vc-segment ()
      (when vc-mode
        (list (all-the-icons-faicon "code-fork" :height 1 :v-adjust 0 :face (vs|git/face))
              " "
              (when (string-match "[-:@!?]\\(.+\\)$" vc-mode)
                (let ((branch (match-string 1 vc-mode)))
                  (if (> (length branch) 20)
                      (format "%s..." (truncate-string-to-width branch 17))
                    branch
                    )
                  )
                )
              )
        )
      )

    (telephone-line-defsegment* vs|modeline/buffer-segment ()
      (let ((icon (if buffer-read-only "lock" "file"))
            (face (if (buffer-modified-p) 'error 'success)))
        (list
         (all-the-icons-faicon icon :face face :v-adjust 0 :height 0.9)
         " "
         mode-line-buffer-identification
         )
        )
      )

    (telephone-line-defsegment vs|modeline/flycheck-segment ()
      (when (bound-and-true-p flycheck-mode)
        (let ((text (pcase flycheck-last-status-change
                      ('finished (if flycheck-current-errors
                                     (let-alist (flycheck-count-errors flycheck-current-errors)
                                       (let ((icon (if .error "times-circle" "minus-circle"))
                                             (face (if .error 'error 'warning)))
                                         (all-the-icons-faicon icon :face face :v-adjust 0 :height 0.9)))
                                   (all-the-icons-faicon "check-circle" :face 'success :v-adjust 0 :height 0.9)))
                      ('running     (all-the-icons-faicon "history" :v-adjust 0 :height 0.9))
                      ('no-checker  (all-the-icons-faicon "minus-circle" :v-adjust 0 :height 0.9))
                      ('not-checked (all-the-icons-faicon "times-circle" :v-adjust 0 :height 0.9))
                      ('errored     (all-the-icons-faicon "times-circle" :v-adjust 0 :height 0.9 :face 'error))
                      ('interrupted (all-the-icons-faicon "minus-circle" :v-adjust 0 :height 0.9 :face 'error))
                      ('suspicious  (all-the-icons-faicon "question-circle" :v-adjust 0 :height 0.9 :face 'warning))
                      )
                    )
              )
          (propertize text
                      'help-echo (pcase flycheck-last-status-change
                                   ('finished "Display errors found by Flycheck")
                                   ('running "Running...")
                                   ('no-checker "No Checker")
                                   ('not-checked "Not Checked")
                                   ('errored "Error!")
                                   ('interrupted "Interrupted")
                                   ('suspicious "Suspicious?")
                                   )
                      'local-map (make-mode-line-mouse-map
                                  'mouse-1 #'flycheck-list-errors)
                      )
          )
        )
      )

    (telephone-line-defsegment vs|modeline/encoding-segment ()
      (let ((sys (coding-system-plist buffer-file-coding-system)))
        (cond
         ((memq (plist-get sys :category) '(coding-category-undecided coding-category-utf-8)) nil)
         (t (upcase (symbol-name (plist-get sys :name))))
         )
        )
      )

    (telephone-line-defsegment vs|modeline/eol-segment ()
      (let (
            (icon (pcase (coding-system-eol-type buffer-file-coding-system)
                    (0 nil      )
                    (1 "windows")
                    (2 "apple"  )
                    )
                  )
            )
        (when icon
          (all-the-icons-faicon icon :v-adjust 0 :height 0.9)
          )
        )
      )

    (telephone-line-defsegment* vs|modeline/buffer-position-segment ()
      "%n %p %4l:%3C "
      )

    (telephone-line-defsegment* vs|modeline/empty ()
      (telephone-line-raw " ")
      )

    ;; Segments order
    (setq telephone-line-lhs
          '(
            (nil . (vs|modeline/major-mode-segment))
            (nil . (vs|modeline/projectile-segment))
            (nil . (vs|modeline/vc-segment        ))
            (nil . (vs|modeline/buffer-segment    ))
            )
          )
    (setq telephone-line-rhs
          '(
            (nil . (vs|modeline/flycheck-segment       ))
            (nil . (vs|modeline/encoding-segment       ))
            (nil . (vs|modeline/eol-segment            ))
            (nil . (vs|modeline/buffer-position-segment))
            )
          )

    ;; Separators
    (setq telephone-line-primary-left-separator    'telephone-line-flat
          telephone-line-secondary-left-separator  'telephone-line-flat
          telephone-line-primary-right-separator   'telephone-line-flat
          telephone-line-secondary-right-separator 'telephone-line-flat
          )

    ;; Height
    (setq telephone-line-height 24)
    )

  ;; Trigger
  (add-hook 'vs-emacs-config-hook #'telephone-line-mode t)

  )

(provide 'use-modeline)
;;; use-modeline.el ends here
